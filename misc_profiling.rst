Profiling & Optimizing Dango
============================


What to Optimize?
-----------------

When optimizing performance of web application, a common mistake is to start with optimizing the slowest page(or API) or going after micro optimizations which are not worth the effort.

In addition to considering response time, we should also consider the traffic it is receving to priorotize the order of optimization.


Metrics
-----------

Let us profile our library django application and find performance bottlenecks.


.. code-block:: shell

    pip install django-silk


Add silk to installed apps and include silk middleware in django settings.


.. code-block:: python

    MIDDLEWARE = [
        ...
        'silk.middleware.SilkyMiddleware',
        ...
    ]

    INSTALLED_APPS = (
        ...
        'silk'
    )


Run migrations so that Silk can create required database tables to store profile data.


.. code-block:: shell

    $ python manage.py makemigrations
    $ python manage.py migrate
    $ python manage.py collectstatic


Include silk urls in root urlconf to view the profile data.

.. code-block:: python

    urlpatterns += [url(r'^silk/', include('silk.urls', namespace='silk'))]


On silk requests page(http://host/silk/requests/), we can see all requests and sort them by overall time or time spent in database.

Silk creates silk_request table which contains information about the requests processed by django.

In this article, we learnt how to profile django webapp and identify bottlenecks to improve performance. In the next article, we wil learn how to optimize these bottlenecks by taking an in-depth look at them.


Aggregration
--------------

Silk doesn't have support for aggregration of metrics and showing show overall picture of the collected data on a dashboard.

We can write an admin view to show a dashboard of the metrics.



Profiling
---------------------


./manage.py runcprofileserver


Optimizing For Performance
--------------------------
