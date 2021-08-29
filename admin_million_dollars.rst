The Million Dollar Admin
========================

Django admin was first released in 2005 and it has gone through a lot of changes since then. Still the admin interface looks clunky compared to most modern web interfaces.

Jacob Kaplan-Moss, one of the core-developers of Django estimated that it will cost 1 million dollars [#million]_ to hire a team to rebuild admin interface from scratch. Until we get 1 million dollars to revamp the admin interface, let's look into alternate solutions.

1. Use django admin with modern themes/skins. Packages like django-grappelli [#grappelli]_, django-suit [#suit]_ extend the existing admin interface  and provide new skin,options to customize the UI etc.

2. Use drop-in replacements for django admin. Packages like xadmin [#xadmin]_, django-admin2 [#admin2]_ are a complete rewrite of django admin. Even though these packages come with lot of goodies and better defaults, they are no longer actively maintained.

3. Use seperate django packages per task.

4. Write our own custom admin interface.


We can start default admin interface or use any drop-in replacements for the admin. Even with this admin interface, we need to write custom views/reports based on business requirements.

In the next chapter, lets start with customizing admin interface.


.. [#million] https://jacobian.org/2016/may/26/so-you-want-a-new-admin/

.. [#grappelli] https://pypi.org/project/django-grappelli/

.. [#suit] https://pypi.org/project/django-suit/

.. [#xadmin] https://pypi.org/project/xadmin/

.. [#admin2] https://pypi.org/project/django-admin2/
