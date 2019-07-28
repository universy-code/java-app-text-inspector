package com.universy.concatenator;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class MapConcatenator {

    private final String concatToken;

    public MapConcatenator(String concatToken) {
        this.concatToken = concatToken;
    }

    public List<String> concatenate(Map<String, Object> elements) {
        return concatenateElements(elements).collect(Collectors.toList());
    }

    public Stream<String> concatenateElements(Map<String, Object> elements) {
        return Optional.of(elements)
                .map(Map::entrySet)
                .map(Collection::stream)
                .orElse(Stream.empty())
                .flatMap(this::transformElements);
    }

    private Stream<String> transformElements(Map.Entry<String, Object> stringObjectEntry) {

        String key = stringObjectEntry.getKey();
        Object object = stringObjectEntry.getValue();

        if (object instanceof String) {
            return Stream.of(key);
        } else if (object instanceof Map) {
            Map<String, Object> mapOfStrings = (Map<String, Object>) object;
            return concatenateElements(mapOfStrings)
                    .map(elements -> key + concatToken + elements);
        }
        return Stream.empty();
    }
}
