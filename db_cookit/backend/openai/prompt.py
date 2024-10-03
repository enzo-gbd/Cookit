import openai
import re

def messageToMealList(message):
    propositions = []

    # Utilisation d'une expression régulière pour trouver les informations de chaque proposition de plat
    pattern = r'^(.*):\s+(\d+)\s+calories.*?([\s\S]*?)(?=\n\n|\Z)'
    matches = re.findall(pattern, message, re.MULTILINE)

    for match in matches:
        nom_plat = match[0][3:]
        calories = match[1]
        recette = match[2].strip()
        propositions.append([nom_plat, calories, recette])
    return propositions

def ask_prompt(prompt):
    openai.api_key = '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'

    completions = openai.Completion.create(
        engine="text-davinci-003",
        prompt=prompt,
        max_tokens=1024,
        n=1,
        stop=None,
        temperature=0.5,
    )

    message = completions.choices[0].text
    return(messageToMealList(message))

if __name__ == "__main__":
    prompt = """tu es cuisinier et expert nutritionniste,
        j'aimerais que tu me donne 4 idées de plats pour2 personnes en sachant que je suis
        allergique a: miel.
        je ne veux pas de: .
        je veux que ce sois: sain.
        J'aimerais si possible que tu me donne le nombre de calories de chaque propositions. Donne moi les propositions sous format: [nom du plat] : [calories par portion] calories par portion : [recette]"""
    print(ask_prompt(prompt))