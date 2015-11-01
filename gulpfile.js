var gulp = require('gulp');
var sourcemaps = require('gulp-sourcemaps');
var babel = require('gulp-babel');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var connect = require('gulp-connect');

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
  return gulp.src('src/**/*.js')
    .pipe(sourcemaps.init())
    .pipe(babel())
    .pipe(concat('build.min.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('public/js'));
});

gulp.task('watch', function () {
  gulp.watch(['public/index.html'], ['html']);
  gulp.watch(['src/**/*.js'], ['scripts', 'html']);
});

gulp.task('default', ['connect', 'watch', 'html', 'scripts']);