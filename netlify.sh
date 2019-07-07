cd /opt/build/repo
npm install
gem install kramdown-asciidoc


export DOC_DIR=target/graphback/docs/
export INDEX_DOC=target/graphback/docs/README.adoc
export NAV_DOC=target/graphback/docs/_sidebar.adoc
mkdir target
mkdir target/modules
mkdir target/modules/ROOT
mkdir target/modules/ROOT/assets
mkdir target/modules/ROOT/assets/images


cd target
git clone https://github.com/finp/graphback.git
cd graphback/docs
find ./ -name "*.md" -type f -exec sh -c \
    'kramdoc --format=GFM --wrap=ventilate --output={}.adoc {}' \;

for f in *.md.adoc; do mv "$f" "$(echo "$f" | sed s/.md.adoc/.adoc/)"; done

cd ../../../

cp -Lr $DOC_DIR target/modules/ROOT/pages

# rename .md.adoc .adoc target/modules/ROOT/pages/*.md.adoc

cp -Lr $DOC_DIR/images target/modules/ROOT/assets/images

cp antora.yml target

cp $NAV_DOC target/modules/ROOT/nav.adoc

cp -Lr $INDEX_DOC target/modules/ROOT/pages/index.adoc


node_modules/.bin/antora  ./site.yml
