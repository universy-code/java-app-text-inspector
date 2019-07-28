package com.universy.i18n;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.universy.files.FileReader;
import com.universy.files.path.PathProvider;
import com.universy.files.path.RelativePathProvider;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class I18NExtractor {

    private final PathProvider pathProvider;

    public I18NExtractor(PathProvider pathProvider) {
        this.pathProvider = pathProvider;
    }

    public Map<String, Object> readI18n() throws IOException {
        String fileContent = new FileReader(pathProvider).read();
        String cleanedContent = cleanFileContent(fileContent);
        return new ObjectMapper().readValue(cleanedContent, HashMap.class);
    }

    private String cleanFileContent(String fileContent) {
        int beginIndex = fileContent.indexOf("{");
        int endIndex = fileContent.length() - 2;
        return fileContent.substring(beginIndex, endIndex);
    }
}
