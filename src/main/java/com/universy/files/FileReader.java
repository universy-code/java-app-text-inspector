package com.universy.files;

import com.universy.files.path.PathProvider;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class FileReader {


    private final PathProvider pathProvider;

    public FileReader(PathProvider pathProvider) {
        this.pathProvider = pathProvider;
    }

    public String read() throws IOException {
        String path = getDirPath();
        return readFile(path);
    }

    private String getDirPath() throws IOException {
        File file = new File(pathProvider.get());
        return file.getAbsolutePath();
    }

    private String readFile(String filePath) {
        StringBuilder contentBuilder = new StringBuilder();
        try (Stream<String> stream = Files.lines(Paths.get(filePath), StandardCharsets.UTF_8)) {
            stream.forEach(s -> contentBuilder.append(s).append("\n"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return contentBuilder.toString();
    }
}

