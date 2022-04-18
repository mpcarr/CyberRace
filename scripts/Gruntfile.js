module.exports = function(grunt) {
  grunt.initConfig({
      concat: {
        dist: {
          src: ['src/**/*.vbs', '!src/unittests/vbsUnit.vbs', '!src/**/*.test.vbs'],
          dest: 'dest/tablescript.vbs',
        },
        state: {
          src: ['src/_colors.vbs', 'src/game.vbs', 'src/state/**/*.vbs'],
          dest: 'dest/tablescript-state.vbs',
        },
        tests:{
          src: ['src/unittests/vbsUnit.vbs', 'dest/tablescript-state.vbs', 'src/**/*.test.vbs'],
          dest: 'dest/tests.vbs',
        }
      },
      exec: {
          tests: 'cscript dest/tests.vbs'
      },
      watch: {
        scripts: {
            files: 'src/**/*.vbs',
            tasks: ['concat', 'exec:tests'],
            options: {  
                atBegin: true
            }
        }
      }
  
    });
  
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-exec');

  
    // Default task(s).
    grunt.registerTask('default', ['concat']);
  
  };