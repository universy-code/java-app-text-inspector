package com.universy.files.path;

public class RelativePathProvider implements PathProvider {

    private final String relativePath;

    public RelativePathProvider(String relativePath) {
        this.relativePath = relativePath;
    }

    @Override
    public String get() {
        return createPath();
    }

    private String createPath() {
        return getBaseDir() + relativePath;
    }

    private String getBaseDir() {
        return System.getProperty("user.dir");
    }
}
