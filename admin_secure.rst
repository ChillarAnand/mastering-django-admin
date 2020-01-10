Securing Django Admin
=====================



There are several security measures that needs to be taken care at system level as well as django level to make sure Django apps are secure. In this chapter let us specifically look at admin related things which needs to be taken care.


Change default path
--------------------

Most of the django sites use `/admin/` as the path for admin interface. This needs to be changed to a different path.



Ensuring proper ACL
--------------------


Honeypot
--------


https://github.com/dmpayton/django-admin-honeypot



2FA
----

https://github.com/Bouke/django-two-factor-auth


ENVironment
-------------

https://github.com/dizballanze/django-admin-env-notice



https://github.com/treyhunner/django-simple-history
