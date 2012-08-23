Install
=======

Clone the Git repository:

::

    git clone https://github.com/jluttine/cholmod-extra.git
    
Run the following commands:

::
    
    cd cholmod-extra
    make
    make install

TODO: Check the installation directory in Makefile!

The documentation can be found in Docs/ folder.  The source files are
readable as such in reStructuredText format.  If you have `Sphinx
<http://sphinx.pocoo.org/>`_ installed, the documentation can be
compiled to, for instance, HTML or PDF using

::

    cd Docs
    make html
    make latexpdf

The documentation can be found also in http://cholmod-extra.readthedocs.org/.
