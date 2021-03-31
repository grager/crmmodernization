/**
 * 
 */
package com.castsoftware.apigateway.controller;

import static java.util.Collections.singletonMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import com.castsoftware.apigateway.exception.CognitoException;
import com.castsoftware.apigateway.security.model.ErrorMessage;
import com.castsoftware.apigateway.security.model.ResponseWrapper;
import com.castsoftware.apigateway.security.model.RestErrorList;

/**
 *
 * @author grager
 * @version
 * @since Jun 28, 2018
 */


@ControllerAdvice
@EnableWebMvc
public class ExceptionController extends ResponseEntityExceptionHandler {


    /**
     * handleException - Handles all the Exception recieving a request, responseWrapper.
     *@param request
     *@param responseWrapper
     *@return ResponseEntity<ResponseWrapper>
     * @user someone
     * @since 2018-09-12 
     */
    @ExceptionHandler(Exception.class)
    public @ResponseBody ResponseEntity<ResponseWrapper> handleException(HttpServletRequest request,
            ResponseWrapper responseWrapper){
    	
        return ResponseEntity.ok(responseWrapper);
    }
    
	/**
	 * handleIOException - Handles all the Authentication Exceptions of the application. 
	 *@param request
	 *@param exception
	 *@return ResponseEntity<ResponseWrapper>
	 * @user someone
	 * @since 2018-09-12 
	 */
	@ExceptionHandler(AuthenticationException.class)
	public ResponseEntity<ResponseWrapper> handleIOException(HttpServletRequest request, CognitoException e){
    	
    	RestErrorList errorList = new RestErrorList(HttpStatus.NOT_ACCEPTABLE, new ErrorMessage(e.getErrorMessage(),e.getErrorCode(), e.getDetailErrorMessage()));
        ResponseWrapper responseWrapper = new ResponseWrapper(null, singletonMap("status", HttpStatus.NOT_ACCEPTABLE), errorList);
        
      
        return ResponseEntity.ok(responseWrapper);
	}
	
	/**
	 * handleJwtException - Handles all the JWT Exceptions of the application. 
	 *@param request
	 *@param exception
	 *@return ResponseEntity<ResponseWrapper>
	 * @user someone
	 * @since 2018-09-12 
	 */
	public ResponseWrapper handleJwtException(HttpServletRequest request, CognitoException e){
    	
    	RestErrorList errorList = new RestErrorList(HttpStatus.UNAUTHORIZED, new ErrorMessage(e.getErrorMessage(),e.getErrorCode(), e.getDetailErrorMessage()));
        ResponseWrapper responseWrapper = new ResponseWrapper(null, singletonMap("status", HttpStatus.UNAUTHORIZED), errorList);
        
      
        return responseWrapper;
	}
	
}