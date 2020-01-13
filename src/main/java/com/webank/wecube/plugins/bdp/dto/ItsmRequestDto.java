package com.webank.wecube.plugins.bdp.dto;

public class ItsmRequestDto {
    private String handler;
    private String formType;
    private String fileUrl;
    private String createTime;
    private String envType;
    private String createUser;
    private String requestNo;
    private String recordSource;

    public ItsmRequestDto(String handler, String formType, String fileUrl, String createTime, String envType, String createUser, String requestNo, String recordSource) {
        this.handler = handler;
        this.formType = formType;
        this.fileUrl = fileUrl;
        this.createTime = createTime;
        this.envType = envType;
        this.createUser = createUser;
        this.requestNo = requestNo;
        this.recordSource = recordSource;
    }

    public ItsmRequestDto() {
    }

    public String getHandler() {
        return handler;
    }

    public void setHandler(String handler) {
        this.handler = handler;
    }

    public String getFormType() {
        return formType;
    }

    public void setFormType(String formType) {
        this.formType = formType;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getEnvType() {
        return envType;
    }

    public void setEnvType(String envType) {
        this.envType = envType;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public String getRequestNo() {
        return requestNo;
    }

    public void setRequestNo(String requestNo) {
        this.requestNo = requestNo;
    }

    public String getRecordSource() {
        return recordSource;
    }

    public void setRecordSource(String recordSource) {
        this.recordSource = recordSource;
    }
}
