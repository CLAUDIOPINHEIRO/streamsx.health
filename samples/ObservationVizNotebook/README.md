## VM Image Setup

  1. Download Anaconda 3.5 and install. Allow Anaconda to update your .bashrc. You will also need to update the version of the Bokeh library installed
      ```
      wget https://repo.continuum.io/archive/Anaconda3-4.1.1-Linux-x86_64.sh
      bash Anaconda3-4.1.1-Linux-x86_64.sh
      conda install bokeh
      ```

  2. Setup the .bashrc to set the PYTHONHOME to the root of anaconda install location.  This is necessary for the streaming analytics application to run.

      Set the following in .bashrc:
      ```
      export PYTHONHOME=/home/streamsadmin/anaconda3
      ```

  3. Restart the domain and instance to pickup the new environment variables
      ```
      source ~/.bashrc
      st stopinstance
      st stopdomain
      st startdomain
      st startinstance
      ```

  5. In the home directory, clone the git repository, navigate to *streamsx.health/samples/ObservationVizNotebook* and run `ant` to build the demo for your platform (< 5 minutes):
      ```
      git clone <repo>
      cd /home/streamsadmin/streamsx.health/samples/ObservationVizNotebook
      ant
      ```

  6. Start the Jupyter notebook from *streamsx.health/samples/ObservationVizNotebook*:
      ```
      jupyter-notebook
      ```

  7. In the web browser, open the *notebooks/ObservationVisualization.pynb* notebook
