var gulp = require('gulp');
var coffee = require('gulp-coffee');
var util = require('gulp-util');
var sourcemaps = require('gulp-sourcemaps');
var concat = require('gulp-concat');
var connect = require('gulp-connect');
var livereload = require('gulp-livereload');
var merge2 = require('merge2');

gulp.task('connect', function() {
  connect.server({
    root: 'public'
  });
});

gulp.task('html', function () {
  gulp.src('public/index.html')
    .pipe(livereload());
});

gulp.task('scripts', function() {
  return merge2(
    merge2(
      /* node modules */
      gulp.src([
        'node_modules/jquery/dist/jquery.min.js',
        'node_modules/bootstrap/dist/js/bootstrap.min.js',
        'node_modules/d3/d3.min.js'
      ]).pipe(sourcemaps.init()),
      /* classes */
      gulp.src(['src/**/*.coffee', '!src/main.coffee'])
          .pipe(coffee({bare: true}).on('error', util.log))
          .pipe(sourcemaps.init())
    ),
    /* main */
    gulp.src(['src/main.coffee'])
        .pipe(coffee({bare: true}).on('error', util.log))
        .pipe(sourcemaps.init())
  ).pipe(concat('build.min.js'))
   .pipe(sourcemaps.write('.'))
   .pipe(gulp.dest('public/js'))
   .pipe(livereload());
});

gulp.task('watch', function () {
  livereload.listen()
  gulp.watch(['public/index.html'], ['html']);
  gulp.watch(['src/**/*.coffee'], ['scripts', 'html']);
});

gulp.task('styles', function() {
  return gulp.src([
    'node_modules/bootstrap/dist/css/bootstrap.min.css'
  ]).pipe(concat('build.min.css'))
    .pipe(gulp.dest('public/css'))
    .pipe(livereload());
});

gulp.task('fonts', function() {
  return gulp.src([
    'node_modules/bootstrap/dist/fonts/**/*'
  ]).pipe(gulp.dest('public/fonts'))
    .pipe(livereload());
});

gulp.task('default', [
  'connect',
  'watch',
  'html',
  'scripts',
  'styles',
  'fonts'
]);