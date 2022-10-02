from flask import Flask, request, render_template, send_from_directory
import os
from PIL import Image, ImageEnhance
from image_and_translate_api import NasaApi
from image_and_translate_api import TranslationApi
from nst_class import NST
import os
import sys
import scipy.io
import scipy.misc
import matplotlib.pyplot as plt
from matplotlib.pyplot import imshow
from PIL import Image
import numpy as np
import tensorflow as tf
import cv2
import pprint
# %matplotlib inline

app = Flask(__name__)

APP_ROOT = os.path.dirname(os.path.abspath(__file__))

# default access page
@app.route("/")
def main():
    return render_template('index.html')


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
    return render_template('index.html')

@app.route("/generate_nst", methods=["POST"])
def generate_nst():
    # Load content and style images
    content_image = np.array(Image.open("static/images/Dark-Matter-Image.png"))
    style_image = np.array(Image.open("images/dbaye-400-400.jpg"))
    # Create an NST object
    nst_object = NST(content_image=content_image, style_image=style_image, img_size=400)
    # Open and resize the content and style images
    content_image = np.array(Image.open("images/nasa-400-400.jpg").resize((nst_object.img_size, nst_object.img_size)))
    content_image = tf.constant(np.reshape(content_image, ((1,) + content_image.shape)))
    style_image = np.array(Image.open("images/dbaye-400-400.jpg").resize((nst_object.img_size, nst_object.img_size)))
    style_image = tf.constant(np.reshape(style_image, ((1,) + style_image.shape)))

    # Display content image
    print(content_image.shape)
    imshow(content_image[0])
    plt.show()

    # Display style image
    print(style_image.shape)
    imshow(style_image[0])
    plt.show()

    # Randomly Initialize the Image to be Generated
    generated_image = tf.Variable(tf.image.convert_image_dtype(content_image, tf.float32))
    noise = tf.random.uniform(tf.shape(generated_image), 0, 0.5)
    generated_image = tf.add(generated_image, noise)
    generated_image = tf.clip_by_value(generated_image, clip_value_min=0.0, clip_value_max=1.0)

    # Display the noisy generated image
    print(generated_image.shape)
    imshow(generated_image.numpy()[0])
    plt.show()

    content_layer = [('block5_conv4', 1)]
    nst_object.style_layers()
    vgg_model_outputs = nst_object.get_layer_outputs(nst_object.load_vgg_model(),
                                                     nst_object.STYLE_LAYERS + content_layer)

    # Save the outputs for the content and style layers in separate variables.
    content_target = vgg_model_outputs(content_image)  # Content encoder
    style_targets = vgg_model_outputs(style_image)  # Style enconder

    # Assign the content image to be the input of the VGG model.
    # Set a_C to be the hidden layer activation from the layer we have selected
    preprocessed_content = tf.Variable(tf.image.convert_image_dtype(content_image, tf.float32))
    a_C = vgg_model_outputs(preprocessed_content)

    # Set a_G to be the hidden layer activation from same layer. Here, a_G references model['conv4_2']
    # and isn't evaluated yet. Later in the code, we'll assign the image G as the model input.
    a_G = vgg_model_outputs(generated_image)

    # Compute the content cost
    J_content = nst_object.compute_content_cost(a_C, a_G)

    print(J_content)

    # Assign the input of the model to be the "style" image
    preprocessed_style = tf.Variable(tf.image.convert_image_dtype(style_image, tf.float32))
    a_S = vgg_model_outputs(preprocessed_style)

    # Compute the style cost
    J_style = nst_object.compute_style_cost(a_S, a_G, nst_object.STYLE_LAYERS)
    print(J_style)

    generated_image = tf.Variable(tf.image.convert_image_dtype(content_image, tf.float32))

    nst_object.optimizer = tf.keras.optimizers.Adam(learning_rate=0.03)

    # Show the generated image at some epochs
    # Uncoment to reset the style transfer process. You will need to compile the train_step function again
    epochs = 2501
    nst_object.nst_training(epochs, generated_image)

    return render_template('index.html')


# retrieve file from 'static_temp/images' directory
@app.route('/static_temp/images/<filename>')
def send_image(filename):
    return send_from_directory("static_temp/images", filename)


@app.route("/pixel_effect", methods=["POST"])
def pixel_effect():
    # some parametters
    image_path = './static/images/Dark-Matter-Image.png'
    size = (32, 32)

    # read the image
    image = Image.open(image_path)

    # Bilinear interpolation
    small_img = image.resize(size, Image.BILINEAR)

    # output image NEAREST
    output_img = small_img.resize(image.size, Image.NEAREST)

    # Display
    plt.imshow(output_img)
    plt.axis('off')
    plt.savefig(fname='./static/images/Dark-Matter-Image.png', transparent=True)
    plt.show()
    return render_template('index.html')

@app.route("/cartoon_effect", methods=["POST"])
def cartoon_effect():
    # some parametters
    image_path = './static/images/Dark-Matter-Image.png'
    # read image into rgb
    img = cv2.imread(image_path)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    # image to grayscale
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    gray = cv2.medianBlur(gray, 5)

    # read edges
    edges = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, 9, 9)
    plt.figure(figsize=(10, 10))

    # cartoon
    color = cv2.bilateralFilter(img, 9, 250, 250)
    cartoon = cv2.bitwise_and(color, color, mask=edges)

    # display img
    plt.figure(figsize=(10, 10))
    plt.imshow(cartoon, cmap="gray")

    # Display
    plt.imshow(cartoon)
    plt.axis('off')
    plt.savefig(fname='./static/images/Dark-Matter-Image.png', transparent=True)
    plt.show()
    return render_template('index.html')


@app.route("/sketch_effect", methods=["POST"])
def sketch_effect():
    # some parametters
    image_path = './static/images/Dark-Matter-Image.png'
    img = cv2.imread(image_path)

    original_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img_gray = cv2.cvtColor(original_img, cv2.COLOR_BGR2GRAY)
    img_invert = cv2.bitwise_not(img_gray)
    img_smoothing = cv2.GaussianBlur(img_invert, (21, 21), sigmaX=0, sigmaY=0)
    img_final = cv2.divide(img_gray, 255 - img_smoothing, scale=250)
    plt.imshow(img_final, cmap="gray", vmin=200, vmax=255)
    plt.axis('off')
    plt.savefig(fname='./static/images/Dark-Matter-Image.png', transparent=True)
    plt.show()
    return render_template('index.html')


@app.route("/watercolor_effect", methods=["POST"])
def watercolor_effect():
    # some parametters
    image_path = './static/images/Dark-Matter-Image.png'
    img = cv2.imread(image_path)
    original_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    watercolour_image = cv2.stylization(original_img, sigma_s=100, sigma_r=0.45)
    plt.imshow(watercolour_image)
    plt.axis('off')
    plt.savefig(fname='./static/images/Dark-Matter-Image.png', transparent=True)
    plt.show()
    return render_template('index.html')


@app.route("/texture_effect", methods=["POST"])
def texture_effect():
    # some parametters
    image_path = './static/images/Dark-Matter-Image.png'
    img = cv2.imread(image_path)
    original_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    sharp_img = cv2.detailEnhance(original_img, sigma_s=40, sigma_r=0.8)
    tex_gray, tex_color = cv2.pencilSketch(sharp_img, sigma_s=10, sigma_r=0.40, shade_factor=0.02)
    plt.imshow(tex_color)
    plt.axis('off')
    plt.savefig(fname='./static/images/Dark-Matter-Image.png', transparent=True)
    plt.show()
    return render_template('index.html')


if __name__ == "__main__":
    app.run()
