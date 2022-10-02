from image_and_translate_api import NasaApi
from image_and_translate_api import TranslationApi
import matplotlib.pyplot as plt


def translate(text_to_translate):
    translation_obj = TranslationApi("en", text_to_translate)
    translation = translation_obj.translate_text()
    return translation


prompt = "lune"
prompt = translate(prompt)
keywords = "planète, l'espace"
keywords = translate(keywords)
nasa_api_obj = NasaApi(search_input=prompt, keywords=keywords)
images = nasa_api_obj.process_images()
plt.imshow(images[0])
plt.show()
