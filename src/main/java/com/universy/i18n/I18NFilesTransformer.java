package com.universy.i18n;

import com.fasterxml.jackson.core.JsonParseException;
import com.universy.concatenator.MapConcatenator;
import com.universy.files.path.AbsolutePathProvider;
import com.universy.i18n.exceptions.AppTextFileCorruptException;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class I18NFilesTransformer {

    public Map<String, List<String>> transform(List<File> i18nFiles) {
        return i18nFiles.stream()
                .collect(Collectors.toMap(
                        File::getName,
                        this::readFile
                ));
    }

    private List<String> readFile(File file) {
        try {
            I18NExtractor i18NExtractor = new I18NExtractor(new AbsolutePathProvider(file.getAbsolutePath()));
            Map<String, Object> stringObjectMap = i18NExtractor.readI18n();
            return new MapConcatenator(".").concatenate(stringObjectMap);
        } catch (JsonParseException e) {
            throw new AppTextFileCorruptException(file.getName());
        } catch (Exception e) {
            return Collections.emptyList();
        }
    }


}
