# BugLogHQ Error Logging for Preside

## Overview

This extension includes the bugLogService.cfc originally from the [BugLogHQ project](https://github.com/oarevalo/BugLogHQ) and uses it to  send errors to BugLogHQ  from the Preside platform.

## Installation

The extension can be [installed through](https://forgebox.io/view/preside-ext-bugloghq).

```sh
box install preside-ext-bugloghq
```

## Configuration

The extension is configured using environment variables:

```sh
PRESIDE_BUGLOG_LISTENER_URL=https://your_bugLog_instance/bugLog/listeners/bugLogListenerREST.cfm
PRESIDE_BUGLOG_APP_NAME=your_app_name_to_appear_in_buglog #e.g. myApp_DEV or MyApp_PROD
PRESIDE_BUGLOG_EMAIL_RECIPIENTS=fixer@bug.com
PRESIDE_BUGLOG_EMAIL_SENDER=siteadmin@myApp.com
```

Once installed and configured the extension will send error reports to your BugLogHQ instance each time an error is raised in Preside. These will be labelled with the app name defined in the env vars above. 
If BugLogHQ is unavailable an email report will be sent to the email recipients defined above.

