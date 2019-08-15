Custom admin actions for individual & bulk objects
----------------------------------------------------

In the earlier chapters, we have re-registered django auth user model using a proxy model.

Django provides admin actions which work on a queryset level. For example, we can select a bunch of users and delete them.



We can also write custom admin actions to perform other operations. For example, we can write a custom admin action to activate selected users.


These custom admin actions are efficient when we are taking an action on bulk items. For taking a specific action on single item, using custom actions will be inefficient.

For example, to delete a single user, we need to follow these steps.

    First, we have to select that user record.

    Next, we have to click on the action dropdown

    Next, we have to select delete action

    Next, we have to click Go button.

    In the next page we have to confirm that we have to delete.

Just to delete a single record, we have to perform 5 clicks. That's too many clicks for a single action.

To simplify the process, we can have delete button at row level. This can be achieved by writing a function which will insert delete button for every record.


.. code-block:: python

    from django.contrib import admin

    from . import models


    class ResourceAdmin(admin.ModelAdmin):
    def delete(self, obj):
    return '<input type="button" value="Delete" onclick="location.href=\'%s/delete/\'" />'.format(obj.pk)

        delete.allow_tags = True
        delete.short_description = 'Delete object'

        list_display = ('book',  'book_type', 'url', 'delete')


    admin.site.register(models.Book)

Now we have an admin with delete button for the records.


To delete an object, just click on delete button and then confirm to delete it. Now, we are deleting objects with just 2 clicks.

We can also have buttons with custom actions. For example, we can add a button which will toggle the active status of an user.

.. code-block:: python


In this chapter, we have seen how to write custom admin actions which work on single item as well as bulk items.
