Better Defaults
=================


Use ModelAdmin
-----------------

When a model is registered with admin, it just shows the string representation of the model object in changelist page.


.. code-block:: python

    from book.models import Book

    admin.site.register(Book)


.. image:: images/admin-defaults-list.png
   :align: center


Django provides ModelAdmin [#f1]_ class which represents a model in admin. We can use the following options to make the admin interface informative and easy to use.

* `list_display` to display required fields and add custom fields.
* `list_filter` to add filters data based on a column value.
* `list_per_page` to set how many items to be shown on paginated page.
* `search_fields` to search for records based on a field value.
* `date_hierarchy` to provide date-based drilldown navigation for a field.
* `readonly_fields` to make seleted fields readonly in edit view.
* `prepopulated_fields` to auto generate a value for a column based on another column.
* `save_as` to enable save as new in admin change forms.

.. code-block:: python

    from book.models import Book
    from django.contrib import admin


    @admin.register(Book)
    class BookAdmin(admin.ModelAdmin):
        list_display = ('id', 'name_colored', 'author', 'published_date', 'cover', 'is_available')
        list_filter = ('is_available',)
        list_per_page = 10
        search_fields = ('name',)
        date_hierarchy = 'published_date'
        readonly_fields = ('created_at', 'updated_at')

        def name_colored(self, obj):
            if obj.is_available:
                color_code = '00FF00'
            else:
                color_code = 'FF0000'
            html = '<span style="color: #{};">{}</span>'.format(color_code, obj.name)
            return format_html(html)

        name_colored.admin_order_field = 'name'
        name_colored.short_description = 'name'



In `list_display` in addition to columns, we can add custom methods which can be used to show calculated fields. For example, we can change book color based on its availability.


.. image:: images/admin-defaults-list3.png
   :align: center



Use better widgets
-------------------

Sometimes widgets provided by Django are not handy to the users. In such cases it is better to add tailored widgets based on the field.

For images, instead of showing a link, we can show thumbnails of images so that users can see the picture in the list view itself.


.. code-block:: python


    @admin.register(Book)
    class BookAdmin(admin.ModelAdmin):
      list_display = ('id', 'name_colored', 'author', 'published_date', 'is_available')

      def thumbnail(self, obj):
        width, height = 100, 200
        html = '<img src="/{url}" width="{width}" height={height} />'
        return format_html(
            html.format(url=obj.cover.url, width=width, height=height)
        )

Viewing and editing JSON field in admin interface will be very difficult in the textbox. Instead, we can use JSON Editor widget provided any third-party packages like django-json-widget, with which viewing and editing JSON data becomes much intuitive.


.. code-block:: python

    from django.contrib.postgres import fields
    from django_json_widget.widgets import JSONEditorWidget

    @admin.register(Book)
    class BookAdmin(admin.ModelAdmin):
        formfield_overrides = {
            fields.JSONField: {
                'widget': JSONEditorWidget
            },
        }


When a choice field has few options, instead of showing dropdown, show radio buttons to make easy to choose.


wsywig editor for rich text.



Sorting Models By Frequency
---------------------------


https://github.com/mishbahr/django-modeladmin-reorder



Customize Header/Title
-----------------------


.. code-block:: python

    admin.site.site_header = 'My administration'



Provide better defaults for model fields
-----------------------------------------

.. code-block:: python


    class Category(models.Model):
        name = ''
        class Meta:
            verbose_name_plural = "categories"

Plural name




.. [#f1] https://docs.djangoproject.com/en/2.2/ref/contrib/admin/#modeladmin-objects
