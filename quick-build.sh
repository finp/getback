export DOC_DIR=target/graphback/docs/
export INDEX_DOC=target/graphback/docs/README.md.adoc
export NAV_DOC=target/graphback/docs/_sidebar.md.adoc

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

cd ../../..

cp -Lr $DOC_DIR target/modules/ROOT/pages

cp -Lr $DOC_DIR/images target/modules/ROOT/assets/images

cp antora.yml target

cp $NAV_DOC target/modules/ROOT/nav.adoc

cp -Lr $INDEX_DOC target/modules/ROOT/pages/index.adoc


antora local-site.yml
