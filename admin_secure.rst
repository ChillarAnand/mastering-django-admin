Securing Django Admin
=====================



There are several security measures that needs to be taken care at system level as well as django level to make sure Django apps are secure. In this chapter let us specifically look at admin related things which needs to be taken care.


Admin Path
----------

Most of the django sites use `/admin/` as the path for admin interface. This needs to be changed to a different path. If you want, you can setup a honeypot server at the default path to see the attacks on your admin site.

https://github.com/dmpayton/django-admin-honeypot


ACL
------

If you have user groups and permissions, it is important to set permissions on object level.




2FA
----

https://github.com/Bouke/django-two-factor-auth



ENVironment
-------------

https://github.com/dizballanze/django-admin-env-notice
