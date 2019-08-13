Gotchas With Dynamic Initial Values In Forms
--------------------------------------------

19 Mar 2015 | 10 min read

Django form fields accept initial argument. So You can set a default value for a field.

In [1]: from django import forms

In [2]: class SampleForm(forms.Form):
   ...:     name = forms.CharField(max_length=10, initial='avil page')
   ...:

In [3]: f = SampleForm()

In [4]: f.as_p()
Out[4]: u'<p>Name: <input maxlength="10" name="name" type="text" value="avil page" /></p>'


Sometimes it is required to override init method in forms and set field initial arguments.

In [11]: from django import forms

In [12]: class AdvancedForm(forms.Form):
   ....:
   ....:    def __init__(self, *args, **kwargs):
   ....:        super().__init__(*args, **kwargs)
   ....:        self.fields['name'].initial =  'override'
   ....:
   ....:        name=forms.CharField(max_length=10)
   ....:

In [13]: f2 = AdvancedForm()

In [14]: f2.as_p()
Out[14]: '<p>Name: <input maxlength="10" name="name" type="text" value="override" /></p>'


Now let's pass some initial data to form and see what happens.

In [11]: from django import forms

In [12]: class AdvancedForm(forms.Form):
   ....:
   ....:    def __init__(self, *args, **kwargs):
   ....:        super().__init__(*args, **kwargs)
   ....:        self.fields['name'].initial = 'override'  # don't try this at home
   ....:
   ....:        name=forms.CharField(max_length=10)
   ....:

In [19]: f3 = AdvancedForm(initial={'name': 'precedence'})

In [20]: f3.as_p()
Out[20]: '<p>Name: <input maxlength="10" name="name" type="text" value="precedence" /></p>'

If You look at the value of input field, it's is NOT the overrided. It still has form initial value!

If You look into source code of django forms to find what is happening, You will find this.

data = self.field.bound_data(
       self.data,
       self.form.initial.get(self.name, self.field.initial)  # precedence matters!!!!
)

So form's initial value has precedence over fields initial values.

So You have to override form's initial value instead of fields's initial value to make it work as expected.

In [21]: from django import forms

In [22]: class AdvancedForm(forms.Form):
   ....:
   ....:    def __init__(self, *args, **kwargs):
   ....:        super().__init__(*args, **kwargs)
   ....:        self.initial['name'] = 'override'  # aha!!!!
   ....:
   ....:        name=forms.CharField(max_length=10)
   ....:

In [23]: f4 = AdvancedForm(initial={'name': 'precedence'})

In [24]: f4.as_p()
Out[24]: '<p>Name: <input maxlength="10" name="name" type="text" value="override" /></p>'
