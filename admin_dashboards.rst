Dashboards
==========


Charts
-------

Often times, a simple chart conveys information better than a large table. However django doesn't have builtin support for charts. Let us create a new admin view to display a chart which shows the number of books that are borrowed in the last 2 weeks days.

Create a proxy model for `BorrowedBooks` and register it in the admin so that we can create additional view for that model.


.. code-block:: python

    class BorrowedBookDashboard(BorrowedBook):
        class Meta:
            proxy = True


.. code-block:: python

    class BorrowedBookDashboardAdmin(admin.ModelAdmin):
        pass


ChangeList view is shown by default when a particular model is opened in admin. We can override this view to show a chart instead of listing all items in a table.

The ModelAdmin class has a method called changelist_view. This method is responsible for rendering the ChangeList page. By overriding this method we can inject chart data into the template context.






Dashboards
-----------

We can create simple dashboards as above without any 3rd party packages. To add more complex dashboards, there are lot of 3rd party packages.

https://github.com/sshwsfc/xadmin

Doesn't have documentation in english.

https://github.com/byashimov/django-controlcenter


https://github.com/geex-arts/django-jet
