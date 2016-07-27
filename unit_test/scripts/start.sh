#!/bin/bash
echo 'Cloning Instapp repo...'
git clone https://github.com/IoTitude/Instapp.git  /usr/src/Instapp
cd /usr/src/Instapp

# If you want to test the latest tagged version

git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag

source /usr/src/Instapp/setup.sh
gulp minjs

# Install Karma + Jasmine
npm install karma karma-jasmine karma-phantomjs-launcher --save-dev
npm install -g karma-cli
npm install -g bower
npm install gulp -g
npm install karma-junit-reporter --save-dev
npm install 

# Add resolution in bower.json to automate angular installation
sed -i '/ionic/c\  "ionic": "driftyco/ionic-bower#1.3.1", "angular": "1.5.7",    "angular-mocks": "^1.5.7"  },  "resolutions": {  "angular": "1.5.8", "angular-mocks": "1.5.8"   ' /usr/src/Instapp/bower.json

bower install angular-mocks --allow-root --save-dev

# Clone tests directory
mkdir -p /usr/src/tmp
cd /usr/src/tmp
git init
git remote add -f origin https://github.com/IoTitude/instapp_tests.git
git config core.sparseCheckout true
echo "unit-testing/tests" >> .git/info/sparse-checkout
git pull origin master
mv unit-testing/tests /usr/src/Instapp
cd /usr/src/Instapp

# Add test task to gulpfile.js
sed -i "1i var karma = require('karma').server;" gulpfile.js

echo "gulp.task('test', function(done) {
    karma.start({
        configFile: __dirname + '/tests/my.conf.js',
        singleRun: true
    }, function() {
        done();
    });
});" >> gulpfile.js

echo 'Ready to run.'

sh /usr/src/scripts/runtests.sh

