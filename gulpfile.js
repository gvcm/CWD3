var gulp = require('gulp');
var sourcemaps = require('gulp-sourcemaps');
var babel = require('gulp-babel');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var connect = require('gulp-connect');
var merge2 = require('merge2');

gulp.task('connect', function() {
  connect.server({
    root: 'public',
    livereload: true
  });
});

gulp.task('html', function () {
  gulp.src('public/index.html')
    .pipe(connect.reload());
});

gulp.task('scripts', function() {
  return merge2(
    /* node modules */
    gulp.src([
      'node_modules/jquery/dist/jquery.min.js',
      'node_modules/bootstrap/dist/js/bootstrap.min.js',
      'node_modules/d3/d3.min.js'
    ]).pipe(sourcemaps.init()),
    /* source */
    gulp.src('src/**/*.js')
      .pipe(sourcemaps.init())
      // .pipe(babel())
      // .pipe(uglify())

  ).pipe(concat('build.min.js'))
   .pipe(sourcemaps.write('.'))
   .pipe(gulp.dest('public/js'))
});

gulp.task('watch', function () {
  gulp.watch(['public/index.html'], ['html']);
  gulp.watch(['src/**/*.js'], ['scripts', 'html']);
});

gulp.task('styles', function() {
  return gulp.src([
    'node_modules/bootstrap/dist/css/bootstrap.min.css'
  ]).pipe(concat('build.min.css'))
    .pipe(gulp.dest('public/css'))
});

gulp.task('fonts', function() {
  return gulp.src([
    'node_modules/bootstrap/dist/fonts/**/*'
  ]).pipe(gulp.dest('public/fonts'))
});

gulp.task('watch', function () {
  gulp.watch(['public/index.html'], ['html']);
  gulp.watch(['src/**/*.js'], ['scripts', 'html']);
});

gulp.task('default', [
  'connect',
  'watch',
  'html',
  'scripts',
  'styles',
  'fonts'
]);