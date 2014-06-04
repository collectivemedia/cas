package org.jasig.cas.authentication.handler;

import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.jasig.cas.authentication.client.UserManagementClient;

public class UserManagementAuthenticationHandler extends AbstractUsernamePasswordAuthenticationHandler {

    private UserManagementClient userManagementClient;

    @Override
    protected boolean authenticateUsernamePasswordInternal(UsernamePasswordCredentials credentials) throws AuthenticationException {
        final String username = getPrincipalNameTransformer().transform(credentials.getUsername());
        final String password = credentials.getPassword();

        return this.userManagementClient.areCredentialsValid(username, password);
    }

    public void setUserManagementClient(UserManagementClient userManagementClient) {
        this.userManagementClient = userManagementClient;
    }

}
