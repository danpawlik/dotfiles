
module.exports = {
  config: {

    updateChannel: 'stable',

    fontSize: 14,

    // fontFamily: 'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontFamily: '"Source Code Pro", "DejaVu Sans Mono", Iosevka, Hack, Monaco, Consolas, "Lucida Console", monospace',

    fontWeight: 'normal',

    fontWeightBold: 'bold',

    lineHeight: 1,

    letterSpacing: 0,

    cursorColor: 'rgba(248,28,229,0.8)',

    cursorAccentColor: '#000',

    cursorShape: 'BLOCK',

    cursorBlink: false,

    foregroundColor: '#fff',

    backgroundColor: '#000',

    selectionColor: 'rgba(248,28,229,0.3)',

    borderColor: '#333',

    css: `
      .header_header {
        background: transparent!important;
      }
      .tab_tab {
        border: 0;
      }
      .tab_active::before {
        border-bottom: 2px solid rgba(255,255,255,.5);
      }
      .tab_hasActivity {
        color: #42a1e4;
      }
      .tab_hasActivity:hover {
        color: #96d4e4;
      }`,

    termCSS: '',

    showHamburgerMenu: '',

    showWindowControls: '',

    padding: '12px 14px',

    colors: {
      black: '#000000',
      red: '#C51E14',
      green: '#1DC121',
      yellow: '#C7C329',
      blue: '#0A2FC4',
      magenta: '#C839C5',
      cyan: '#20C5C6',
      white: '#C7C7C7',
      lightBlack: '#686868',
      lightRed: '#FD6F6B',
      lightGreen: '#67F86F',
      lightYellow: '#FFFA72',
      lightBlue: '#6A76FB',
      lightMagenta: '#FD7CFC',
      lightCyan: '#68FDFE',
      lightWhite: '#FFFFFF',
    },

    shell: '/bin/zsh',

    shellArgs: ['--login'],

    env: {},

    bell: 'SOUND',

    copyOnSelect: false,

    defaultSSHApp: true,

    summon: {
      hotkey: 'Cmd+`'
    },
    hypercwd: {
      initialWorkingDirectory: '$HOME'
    },
    hyperStatusLine: {
      dirtyColor: 'salmon',
      aheadColor: 'ivory',
      footerTransparent: false
    },
    hyperTabs: {
      trafficButtons: true,
      border: false,
      tabIconsColored: true,
      closeAlign: 'right',
    },
    hyperTransparent: {
      backgroundColor: '#000',
      opacity: 0.8,
      vibrancy: 'ultra-dark' // ['', 'dark', 'medium-light', 'ultra-dark']
    },

    // change chars from mac layout to linux:
    // cmd: s/cmd/control/g
    paneNavigation: {
      debug: false,
      hotkeys: {
        navigation: {
          up: 'cmd+shift+up',
          down: 'cmd+shift+down',
          left: 'cmd+shift+left',
          right: 'cmd+shift+right'
        },
        jump_prefix: 'cmd+shift', // completed with 1-9 digits
        permutation_modifier: 'shift', // Added to jump and navigation hotkeys for pane permutation
        maximize: 'cmd+shift+enter'
      },
      showIndicators: true, // Show pane number
      indicatorPrefix: '^⌥', // Will be completed with pane number
      indicatorStyle: { // Added to indicator <div>
        position: 'absolute',
        top: 0,
        left: 0,
        fontSize: '10px'
      },
      focusOnMouseHover: false,
      inactivePaneOpacity: 0.6 // Set to 1 to disable inactive panes dimming
    },

  },

  plugins: [
    "hyper-tabs-enhanced",
    "hypercwd",
    "hyper-broadcast",
    "hyperterm-paste",
    "hyper-statusline",
    "hyperterm-summon",
    "hyper-search",
    "hyper-pane",
    "verminal",
  ],
//    "hyperterm-material",
//    "hyper-transparent-bg",

  localPlugins: [],

  keymaps: {
  },
};
