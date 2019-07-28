package com.universy.files.path;

public class AbsolutePathProvider implements PathProvider {

    private final String path;

    public AbsolutePathProvider(String path) {
        this.path = path;
    }

    @Override
    public String get() {
        return path;
    }
}
