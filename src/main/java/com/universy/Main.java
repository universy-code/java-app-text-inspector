package com.universy;

import com.fasterxml.jackson.core.JsonParseException;
import com.universy.files.DirectoryFileExplorer;
import com.universy.files.FileReader;
import com.universy.files.path.AbsolutePathProvider;
import com.universy.files.path.RelativePathProvider;
import com.universy.i18n.I18NFilesTransformer;
import com.universy.i18n.exceptions.AppTextFileCorruptException;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


public class Main {

    private static final String I18N_PATH = "/lib/com/universy/apptext/translations/i18n";
    private static final String WIDGET_PATH = "/lib";

    public static void main(String[] args) {

        try {

            String userName = System.getProperty("user.name");
            String userDir = System.getProperty("user.dir");

            System.out.println(String.format("Hello %s!", userName));
            System.out.println(String.format("We are on: %s", userDir));

            System.out.println(String.format("Reading i18n files in %s", I18N_PATH));
            DirectoryFileExplorer i18nFilesExplorer = new DirectoryFileExplorer(new RelativePathProvider(I18N_PATH));
            List<File> i18nFiles = i18nFilesExplorer.getFilesOfDirectory();

            I18NFilesTransformer transformer = new I18NFilesTransformer();
            Map<String, List<String>> i18nPaths = transformer.transform(i18nFiles);

            System.out.println(String.format("Reading widgets files in %s", WIDGET_PATH));
            System.out.println();

            DirectoryFileExplorer widgetFilesExplorer = new DirectoryFileExplorer(new RelativePathProvider(WIDGET_PATH));
            List<File> widgetFiles = widgetFilesExplorer.getFilesOfDirectory();

            for (File file : widgetFiles) {
                String content = new FileReader(new AbsolutePathProvider(file.getAbsolutePath())).read();

                i18nPaths.keySet()
                        .forEach(key ->
                                i18nPaths.computeIfPresent(key, (fileName, paths) ->
                                        paths.stream()
                                                .filter(path -> !content.contains(path))
                                                .collect(Collectors.toList()))
                        );
            }

            i18nPaths.forEach(
                    (fileName, paths) -> {
                        if (!paths.isEmpty()) {
                            System.out.println(String.format(">> File %s has these unused texts:", fileName));
                            paths.forEach(System.out::println);
                            System.out.println();
                        }
                    }
            );
        } catch (AppTextFileCorruptException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(String.format("There was an error: %s. Sorry!", e.getMessage()));
        }
    }
}
