package org.jasig.cas.authentication.handler;

import org.apache.commons.codec.digest.DigestUtils;
import org.jasig.cas.authentication.client.UserManagementClient;
import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;

public class UserManagementAuthenticationHandler extends AbstractUsernamePasswordAuthenticationHandler {

    private UserManagementClient userManagementClient;

    @Override
    protected boolean authenticateUsernamePasswordInternal(UsernamePasswordCredentials credentials) throws AuthenticationException {
        final String username = getPrincipalNameTransformer().transform(credentials.getUsername());
        final String encryptedPassword = DigestUtils.shaHex(credentials.getPassword());

        return this.userManagementClient.areCredentialsValid(username, encryptedPassword);
    }

    public void setUserManagementClient(UserManagementClient userManagementClient) {
        this.userManagementClient = userManagementClient;
    }

}
