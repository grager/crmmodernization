package com.castsoftware.apigateway.authentication;

import static com.nimbusds.jose.JWSAlgorithm.RS256;

import java.net.MalformedURLException;
import java.net.URL;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;

import com.castsoftware.apigateway.security.filter.AwsCognitoIdTokenProcessor;
import com.castsoftware.apigateway.security.filter.AwsCognitoJwtAuthenticationFilter;
import com.castsoftware.apigateway.util.AWSConfig;
import com.nimbusds.jose.jwk.source.JWKSource;
import com.nimbusds.jose.jwk.source.RemoteJWKSet;
import com.nimbusds.jose.proc.JWSKeySelector;
import com.nimbusds.jose.proc.JWSVerificationKeySelector;
import com.nimbusds.jose.util.DefaultResourceRetriever;
import com.nimbusds.jose.util.ResourceRetriever;
import com.nimbusds.jwt.proc.ConfigurableJWTProcessor;
import com.nimbusds.jwt.proc.DefaultJWTProcessor;

/**
 * Method that exposes the AWS Cognito configuration.
 * @author grager
 * @version
 * @since Jun 26, 2018
 */
@Configuration
@Import(AWSConfig.class)
@ConditionalOnClass({AwsCognitoJwtAuthenticationFilter.class, AwsCognitoIdTokenProcessor.class})
public class CognitoJwtAutoConfiguration {

    @Bean
    @Scope(value="request", proxyMode= ScopedProxyMode.TARGET_CLASS)
    public CognitoJwtIdTokenCredentialsHolder awsCognitoCredentialsHolder() {
        return new CognitoJwtIdTokenCredentialsHolder();
    }

    @Bean
    public AwsCognitoIdTokenProcessor awsCognitoIdTokenProcessor() { return new AwsCognitoIdTokenProcessor(); }

    @Bean
    public CognitoJwtAuthenticationProvider jwtAuthenticationProvider() { return new CognitoJwtAuthenticationProvider(); }


    @Bean
    public AwsCognitoJwtAuthenticationFilter awsCognitoJwtAuthenticationFilter() {
        return new AwsCognitoJwtAuthenticationFilter(awsCognitoIdTokenProcessor());
    }

	@Autowired(required=true)
	private AWSConfig jwtConfiguration;

    /**
     * Method that exposes the cognito configuration. 
     *@return ConfigurableJWTProcessor 
     *@throws MalformedURLException
     * @user someone
     * @since 2018-06-26 
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@Bean
	public ConfigurableJWTProcessor configurableJWTProcessor() throws MalformedURLException {
        ResourceRetriever resourceRetriever = new DefaultResourceRetriever(jwtConfiguration.getConnectionTimeout(), jwtConfiguration.getReadTimeout());
        //https://cognito-idp.{region}.amazonaws.com/{userPoolId}/.well-known/jwks.json.
        URL jwkSetURL = new URL(jwtConfiguration.getJwkUrl());
        //Creates the JSON Web Key (JWK)
        JWKSource keySource = new RemoteJWKSet(jwkSetURL, resourceRetriever);
        ConfigurableJWTProcessor jwtProcessor = new DefaultJWTProcessor();
        JWSKeySelector keySelector = new JWSVerificationKeySelector(RS256, keySource);
        jwtProcessor.setJWSKeySelector(keySelector);
        return jwtProcessor;
    }

}