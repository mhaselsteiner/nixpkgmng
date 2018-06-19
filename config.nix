{ allowUnfree = true;
  packageOverrides = super: let self = super.pkgs; in {
    myPythonEnv27 = self.python2.buildEnv.override {
      ignoreCollisions = true;
      extraLibs = with self.pythonPackages; [
        basemap
#        epygram
        netcdf4
        ipython
        matplotlib
        netcdf4
        numpy
        pandas
        seaborn
#        pint
        pytest
        scikitlearn
        scipy

#        MENT_verif_tool
      ];
    };
     myPythonEnv3 = self.python3.buildEnv.override {
      ignoreCollisions = true;
      extraLibs = with self.pythonPackages; [
        basemap
#        epygram
        netcdf4
        ipython
        matplotlib
        netcdf4
        numpy
        pandas
        seaborn
#        pint
        pytest
        scikitlearn
        scipy
#        MENT_verif_tool
      ];
    };

    config.vim.ruby = false; # Because the ruby build fails with our nixpkgs-version
    myVim = super.pkgs.vim_configurable.customize {
      name = "myVim";
      vimrcConfig = {
        customRC = ''
          set expandtab
          set shiftwidth=2
          set softtabstop=2
          set backspace=indent,eol,start
          set autoindent
          function! SKEL_spec()
                  0r /usr/share/vim/current/skeletons/skeleton.spec
                  language time en_US
                  let login = system('whoami')
                  if v:shell_error
                     let login = 'unknown'
                  else
                     let newline = stridx(login, "\n")
                     if newline != -1
                          let login = strpart(login, 0, newline)
                     endif
                  endif
                  let hostname = system('hostname -f')
                  if v:shell_error
                      let hostname = 'localhost'
                  else
                      let newline = stridx(hostname, "\n")
                      if newline != -1
                          let hostname = strpart(hostname, 0, newline)
                      endif
                  endif
                  exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
                  exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
                  exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
          endfunction
          autocmd BufNewFile      *.spec  call SKEL_spec()

          set hidden
          set colorcolumn=100 
          '';
        packages.myVimPackage = with super.vimPlugins; {
          start = [ 
                   # python-mode
                    youcompleteme
                    ];
        };        
      };
    };
    myPkgs = with self; buildEnv {
      name = "myPkgs";
      paths = [
#        myPythonEnv27
        myPythonEnv3
#        nco
#        bvi
#        cgdb
#        diffoscope
#        duc
#        ecflow
#        gdal
#        gdb
        gitAndTools.diff-so-fancy
        gitAndTools.gitFull
#        gqview
#        gridpp
        htop
        indent
#        jetbrains.pycharm-community
#        jq
        nix-prefetch-scripts
        parallel
        patchelf
        procps-ng # watch command
#        python36Packages.yapf
        qgis
        sshfs
        sublime3
#        tree
#        valgrind
        view_swap
#        vim
        ncview #fancy ncddf viewer with gui
        myVim
        python36Packages.yapf
        vscode
      ];
    }; 
  };
}
