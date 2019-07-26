Make Django Development Server Persistent
-----------------------------------------

20 Jul 2015 | 4 min read
I use Emacs for writing Python code. I also use real-auto-save to save my files after 10 seconds of inactivity.
While coding, when I stop writing in the middle, after 10 seconds Emacs auto saves the file. Django recognizes this & reloads the development server.
Once I complete writing code, I go to browser & refresh the page. Since the code I was writing was incomplete somewhere in the middle and had some errors, Django development server was stopped and page won't reload. Now I have to go back to terminal and restart the server and again go back to browser to refresh page.
To overcome this, Django server must be made persistent. The easiest way to accomplish this is to use a simple bash script as described here.
$ while true; do python manage.py runserver; sleep 4; done
When Django development server stops, after 4 seconds it tries to start automatically and goes on forever.
Instead of typing that everytime, it better to write this as a shell script and put it in system path, so that it can be used in any project.
while true; do
  echo "Re-starting Django runserver"
  python manage.py runserver
  sleep 4
done
Save this & make it executable(chmod +x), use it is ./filename.sh and to stop use Ctrl-c Ctrl-c
django django-tips-tricks python
Previous post Next post
        Written by
Chillar Anand
Musings about programming, careers & life.
Comments

Contents © 2019 Chillar Anand - Powered by Nikola
