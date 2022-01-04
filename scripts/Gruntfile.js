module.exports = function(grunt) {
  grunt.initConfig({
      concat: {
        dist: {
          src: ['src/**/*.vbs'],
          dest: 'dest/tablescript.vbs',
        },
      },
  
      watch: {
        scripts: {
            files: 'src/**/*.vbs',
            tasks: ['concat'],
            options: {
                atBegin: true
            }
        }
      }
  
    });
  
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-watch');
  
    // Default task(s).
    grunt.registerTask('default', ['concat']);
  
  };