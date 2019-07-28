package com.universy.i18n.exceptions;

public class AppTextFileCorruptException extends IllegalArgumentException {

    private static final String ERROR_TEMPLATE = "The file %s is corrupt. \n" +
            "You can use this tool https://jsonformatter.curiousconcept.com to validate.";

    public AppTextFileCorruptException(String fileName) {
        super(String.format(ERROR_TEMPLATE, fileName));
    }
}
