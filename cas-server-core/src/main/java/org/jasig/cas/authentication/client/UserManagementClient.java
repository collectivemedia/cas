package org.jasig.cas.authentication.client;

import org.springframework.web.client.RestTemplate;

public class UserManagementClient {

    private RestTemplate restTemplate;
    private String userManagementBaseUrl;

    public boolean areCredentialsValid(String login, String password) {
        String url = this.userManagementBaseUrl + "user/areCredentialsValid?login=" + login + "&password=" + password;
        String result = this.restTemplate.getForObject(url, String.class);
        return Boolean.valueOf(result);
    }

    public void setRestTemplate(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public void setUserManagementBaseUrl(String userManagementBaseUrl) {
        this.userManagementBaseUrl = userManagementBaseUrl;
    }

}
