# web-app for API image manipulation

from flask import Flask, request, render_template, send_from_directory
import os
from PIL import Image, ImageEnhance
from image_and_translate_api import NasaApi
from image_and_translate_api import TranslationApi
import matplotlib.pyplot as plt
# nst_class.load_vgg_model()

app = Flask(__name__)

APP_ROOT = os.path.dirname(os.path.abspath(__file__))

# default access page
@app.route("/")
def main():
    return render_template('index.html')


# upload selected image and forward to processing page
@app.route("/upload", methods=["POST"])
def upload():
    target = os.path.join(APP_ROOT, 'static_temp/images/')

    # create image directory if not found
    if not os.path.isdir(target):
        os.mkdir(target)
    # retrieve file from html file-picker
    upload = request.files.getlist("file")[0]
    print("File name: {}".format(upload.filename))
    filename = upload.filename

    # file support verification
    ext = os.path.splitext(filename)[1]
    if (ext == ".jpg") or (ext == ".png") or (ext == ".bmp"):
        print("File accepted")
    else:
        return render_template("error.html", message="The selected file is not supported"), 400

    # save file
    destination = "/".join([target, filename])
    print("File saved to to:", destination)
    upload.save(destination)

    # forward to processing page
    return render_template("processing.html", image_name=filename)



def translate(text_to_translate):
    translation_obj = TranslationApi("en", text_to_translate)
    translation = translation_obj.translate_text()
    return translation


@app.route("/userInput", methods=["POST"])
def userInput():
    # retrieve parameters from html form
    prompt = request.form['userInput']
    prompt = translate(prompt)
    keywords = request.form['keywords']
    keywords = translate(keywords)
    nasa_api_obj = NasaApi(search_input=prompt, keywords=keywords)
    images = nasa_api_obj.process_images()
    plt.imshow(images[1])
    plt.axis('off')
    plt.savefig(fname='./static/images/Dark-Matter-Image.png', transparent=True)
    plt.show()

    #plt.imsave("./static/images/Dark-Matter-Image.jpeg", images[0])
    # output = open("./static/images/Dark-Matter-Image.jpeg", "wb")
    # output.write(images[0])
    # output.close()
    # return images
    return render_template('index.html')

# rotate filename the specified degrees
@app.route("/rotate", methods=["POST"])
def rotate():
    # retrieve parameters from html form
    angle = request.form['angle']
    filename = request.form['image']

    # open and process image
    target = os.path.join(APP_ROOT, 'static_temp/images')
    destination = "/".join([target, filename])

    img = Image.open(destination)
    img = img.rotate(-1 * int(angle))

    # save and return image
    destination = "/".join([target, 'temp.png'])
    if os.path.isfile(destination):
        os.remove(destination)
    img.save(destination)

    return send_image('temp.png')


# retrieve file from 'static_temp/images' directory
@app.route('/static_temp/images/<filename>')
def send_image(filename):
    return send_from_directory("static_temp/images", filename)


if __name__ == "__main__":
    app.run()
