Dealing With CSRF Token Outside Of Django
==========================================


Ajax
-----


When making ajax calls from browser, we need to set CSRF token.


Postman
-------

Django has inbuilt CSRF protection mechanism for requests via unsafe methods to prevent Cross Site Request Forgeries. When CSRF protection is enabled on AJAX POST methods, X-CSRFToken header should be sent in the request.

Postman is one of the widely used tool for testing APIs. In this article, we will see how to set csrf token and update it automatically in Postman.
CSRF Token In Postman

Django sets csrftoken cookie on login. After logging in, we can see the csrf token from cookies in the Postman.

We can grab this token and set it in headers manually.

But this token has to be manually changed when it expires. This process becomes tedious to do it on an expiration basis.

Instead, we can use Postman scripting feature to extract token from cookie and set it to an environment variable. In Test section of postman, add these lines.

var xsrfCookie = postman.getResponseCookie("csrftoken");
postman.setEnvironmentVariable('csrftoken', xsrfCookie.value);

This extracts csrf token and sets it to an evironment variable called csrftoken in the current environment.

Now in our requests, we can use this variable to set the header.

When the token expires, we just need to login again and csrf token gets updated automatically.
Conclusion

In this article we have seen how to set and renew csrftoken automatically in Postman. We can follow similar techniques on other API clients like CURL or httpie to set csrf token.


Shell
------

HTTPie is an alternative to curl for interacting with web services from CLI. It provides a simple and intuitive interface and it is handy to send arbitrary HTTP requests while testing/debugging APIs.

When working with web applications that require authentication, using httpie is difficult as authentication mechanism will be different for different applications. httpie has in built support for basic & digest authentication.

To authenticate with Django apps, a user needs to make a GET request to login page. Django sends login form with a CSRF token. User can submit this form with valid credentials and a session will be initiated.

Establish session manually is boring and it gets tedious when working with multiple apps in multiple environments(development, staging, production).

I have written a plugin called httpie-django-auth which automates django authentication. It can be installed with pip

pip install httpie-django-auth

By default, it uses /admin/login to login. If you need to use some other URL for logging, set HTTPIE_DJANGO_AUTH_URL environment variable.

export HTTPIE_DJANGO_AUTH_URL='/accounts/login/'

Now you can send authenticated requests to any URL as

http :8000/profile -A=django --auth='username:password'
