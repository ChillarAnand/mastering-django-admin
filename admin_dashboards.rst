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

The ModelAdmin class has a method called changelist_view. This method is responsible for rendering the ChangeList page. By overriding this method we can pass chart data to the template.

.. code-block:: python

.. code-block:: python

    class BorrowedBookDashboardAdmin(admin.ModelAdmin):

        def changelist_view(self, request, extra_context=None):
            qs = BorrowedBook.objects.annotate(date=TruncDay("updated_at")).values("date").annotate(
                count=Count("id")).values_list('date', 'count').order_by('-date')
            qs = qs.extra(select={'datestr': "to_char(date, 'YYYY-MM-DD')"})
            extra_context = {
                'chart_labels': list(chart_data.keys()),
                'chart_data': list(chart_data.values()),
            }
            return super().changelist_view(request, extra_context=extra_context)


Dashboards
-----------

We can create simple dashboards as above without any 3rd party packages. To add more complex dashboards, there are lot of 3rd party packages.

https://github.com/sshwsfc/xadmin

Doesn't have documentation in english.

https://github.com/byashimov/django-controlcenter


https://github.com/geex-arts/django-jet
