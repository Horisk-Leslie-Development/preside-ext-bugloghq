component {

	public void function raiseError( required struct error ) {
		var buglogClient = _getbuglogClient();
       
		if ( !IsNull( buglogClient ) ) {
            
            savecontent variable="local.mailbody" {
                writeOutput("
                    An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
                    Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#<br />
                    Referer: #cgi.http_referer#<br />
                    Error reference <br />
                    ");
                    writedump(form);
                    writedump(url);
                    writedump(cgi);
               }
            
            systemOutput( "An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#" );
            buglogClient.notifyService("#error.cause.message#", error, mailBody, "fatal");
            
		}
	}

// private
	private any function _getbuglogClient() {
		systemOutput(_getListenerUrl());
        systemOutput(_getAppName());
        systemOutput(_getBugLogEmailRecipients());
        systemOutput(_getBugLogEmailSender());
        return new buglogService(
            bugLogListener = _getListenerUrl(),
            apiKey = "",
            appName = _getAppName(),
            hostName = cgi.HTTP_HOST,
            bugEmailRecipients = _getBugLogEmailRecipients(),
            bugEmailSender = _getBugLogEmailSender());

	}

	private string function _getListenerUrl() {
		return application.PRESIDE_BUGLOG_LISTENER_URL ?: ( application.injectedConfig.PRESIDE_BUGLOG_LISTENER_URL ?: "" );
	}

	private string function _getAppName() {
		return application.PRESIDE_BUGLOG_APP_NAME ?: ( application.injectedConfig.PRESIDE_BUGLOG_APP_NAME ?: "" );
	}

    private string function _getBugLogEmailRecipients() {
		return application.PRESIDE_BUGLOG_EMAIL_RECIPIENTS ?: ( application.injectedConfig.PRESIDE_BUGLOG_EMAIL_RECIPIENTS ?: "" );
	}
    
    private string function _getBugLogEmailSender() {
		return application.PRESIDE_BUGLOG_EMAIL_SENDER ?: ( application.injectedConfig.PRESIDE_BUGLOG_EMAIL_SENDER ?: "" );
	}
	/* private string function _getAppVersion() {
		return application.SENTRY_APP_VERSION ?: ( application.injectedConfig.SENTRY_APP_VERSION ?: "" );
	} */

}