Admin Cosmotics
=================


Customize Header/Title
-----------------------


.. code-block:: python

    admin.site.site_header = 'My administration'



Plural names
--------------

.. code-block:: python


    class Category(models.Model):
        class Meta:
            verbose_name_plural = "categories"
