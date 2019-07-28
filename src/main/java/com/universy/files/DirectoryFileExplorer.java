package com.universy.files;

import com.universy.files.path.PathProvider;

import java.io.File;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class DirectoryFileExplorer {

    private final PathProvider pathProvider;


    public DirectoryFileExplorer(PathProvider pathProvider) {
        this.pathProvider = pathProvider;
    }

    public List<File> getFilesOfDirectory(){
        File baseFile = new File(pathProvider.get());
        return getFiles(baseFile).collect(Collectors.toList());
    }

    public Stream<File> getFiles(File file){
        return Optional.of(file)
                .filter(File::isDirectory)
                .map(File::listFiles)
                .map(Stream::of)
                .map(f -> f.flatMap(this::getFiles))
                .orElse(Stream.of(file));
    }
}
