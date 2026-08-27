---
blog: nitza-develop
tipo_post: C
---

# Why We're Called Nitza Develop

![Handwritten recipe card with a pencil correction](https://blog-media.ladetec.com/nitza-develop/cocina_al_minuto/cocina_al_minuto-1.webp)

During the hardest years of Cuba's Special Period — the severe economic crisis of the 1990s that followed the collapse of Soviet subsidies — Nitza Villapol was still on air. She'd already spent four decades teaching people to cook on Cuban television, but during those years the show changed in nature: it was no longer about presenting an ideal recipe, but about making do with whatever was actually available that week. According to NPR, citing Andrés Oppenheimer's book *Castro's Final Hour* — a secondary source we haven't been able to verify directly against the original book — Villapol would check with government officials about available rations before taping each episode. She wasn't teaching the perfect recipe. She was teaching people to take last week's recipe, remove whatever wasn't available, substitute whatever was, and explain the reasoning behind each change so that whoever was watching at home could repeat the reasoning, not just the dish.

That gesture — taking something made by someone else, understanding it well enough to adapt it to the real context, and handing it back explained so the next person doesn't start from zero — is practically the same idea Richard Stallman uses to explain free software. And that overlap, more than a curiosity, is the reason this company is called Nitza Develop.

## Nitza Villapol's Kitchen

Nitza Villapol was born in New York in 1923 and settled in Havana, where she earned a doctorate in Education in 1948 before devoting herself fully to television. Her show, *Cocina al Minuto* ("Cooking in a Minute"), premiered on July 3, 1951, and became one of the longest-running programs in Cuban TV history. In 1958 she published a book of the same name, reissued several times over the following decades, and she's often compared to Julia Child as a television cooking educator. She died on October 20, 1998, having taught several generations how to cook — in both the literal and the broader sense.

What makes her work memorable isn't just the show's longevity, but the moment its function shifted: when ingredients stopped being an aesthetic choice and became a hard constraint, Villapol didn't abandon the recipe format. She adapted it. She turned the recipe into a tool for thinking with what's available, not a fixed object to be followed to the letter or discarded entirely.

## The Recipe Stallman Uses to Explain Free Software

![Conceptual illustration blending a handwritten recipe with a code fragment](https://blog-media.ladetec.com/nitza-develop/cocina_al_minuto/cocina_al_minuto-2.webp)

Richard Stallman reaches for that same image — the recipe — to explain free software in his talk *Free Software: Freedom and Cooperation*, delivered at NYU on May 29, 2001. He describes receiving a recipe from a friend, being able to modify it (drop an ingredient, add mushrooms), and sharing it again with whoever needs it [VERIFICAR: confirm the exact quote directly against gnu.org; the transcript was consulted as a source, but couldn't be verified against a direct reading of the full document]. From that image, Stallman builds the four formal freedoms that define free software in the GNU Free Software Definition: to use it, to study and modify it, to redistribute it, and to distribute modified versions [VERIFICAR: same direct-verification caveat against gnu.org].

Anyone who writes code recognizes the pattern immediately, even if they've never fried an egg following instructions: you receive code written by someone else, you read it until you understand why it makes the decisions it makes, you change it to fit your context — your infrastructure, your constraints, your team — and, if it makes sense, you hand it back to the community with the change explained. There's no perfect recipe and no perfect library. There's a reasonable starting point and the freedom to modify it without asking permission.

## Two Ways of Teaching the Same Thing

That's the point of convergence that gives this company its name. Villapol used recipes to teach people to work with what's real instead of waiting for what's ideal. Stallman, using that same recipe metaphor, described a way of working where knowledge is shared, modified openly, and handed back improved. They're not the same discipline, but they share the same underlying principle: the value isn't in protecting the recipe — it's in letting it circulate, adapt, and letting someone else follow the reasoning behind every change.

This is how we want to approach software development at Nitza Develop: not starting from some ideal architecture in the abstract and then looking for a project to justify it, but starting from what the client actually has available — their current stack, their team, their budget, their time constraints — and building with that, trying to document the reasoning behind each decision so the team that inherits the project can follow the thread, not just the final result. It's the same logic of "cooking with what's on hand" applied to deciding whether to extend a legacy system or rewrite a module, and the same logic of "sharing the modified recipe" applied to our intention of leaving code that's readable and documented, with clear licensing, when using or publishing free software is the right call.

That's why the name isn't a gratuitous pun. It's a statement of values: this is how we try to work, with what's real instead of what's ideal, sharing the reasoning behind every change instead of handing over a closed box. "Nitza" for the teacher who turned scarcity into a method without losing sight of the people following along at home. "Develop" because that method, applied to code, is the software development standard we set out to follow: iterative, adapted to the context of whoever will maintain it, and open for someone else to understand and carry forward.

If you're curious how we think through these decisions when building software for a real client, follow us on social media and tell us what you think of the parallel.

<!-- ADAPTACIONES CULTURALES REALIZADAS
- Se añadió un glosa breve para "Período Especial" ("the severe economic crisis of the 1990s that followed the collapse of Soviet subsidies") en la primera mención: el término es ampliamente reconocido en el público hispanohablante original, pero opaco para un público angloparlante general (desarrolladores/arquitectos de software) sin ese contexto histórico. Es información histórica de dominio público, no un dato nuevo sobre Villapol, Stallman o la empresa, y no está sujeta a los [VERIFICAR] existentes.
- Se añadió la traducción entre paréntesis del nombre del programa, "Cocina al Minuto" → "(Cooking in a Minute)", porque el título en español comunica algo (inmediatez, resolver rápido) a un lector hispanohablante que se pierde por completo si se deja sin traducir para un lector angloparlante. No es un dato nuevo, es la traducción literal del nombre propio ya presente en el original.
- Se mantuvieron sin adaptar las referencias a NPR y a Julia Child: ambas ya son referencias angloparlantes/estadounidenses en el borrador original y funcionan igual o mejor para el público en inglés sin ningún cambio.
- Se preservaron íntegros y sin resumir los dos [VERIFICAR] sobre las citas de Stallman (discurso en NYU y las cuatro libertades de la Free Software Definition) y el caveat de fuente secundaria sobre la anécdota de las raciones vía NPR/Oppenheimer — ningún cambio de alcance o de tono en esas advertencias respecto al borrador español.
- El CTA se tradujo de forma natural ("follow us on social media and tell us what you think of the parallel") en vez de calcar la construcción española palabra por palabra, manteniendo el mismo llamado único a la acción y coherente con `marca.cta_tipica` de nitza-develop.
- Se mantuvo el mismo marco de "intención/aspiración" (want to, try to, set out to) en los dos párrafos finales sobre la metodología interna de la empresa, replicando la formulación en primera persona plural que el crítico ya validó en 04-review.md como conforme con `marca.evitar: ["promesas sin sustento"]`. No se presentó la metodología como hecho consumado en ningún punto de la traducción.
- No se corrigió la ambigüedad menor señalada como ADVERTENCIA (no BLOQUEO) en 04-review.md sobre la oración "cocinar con lo que hay" aplicada a legado vs. reescritura de módulo: se tradujo preservando la misma estructura gramatical del original, ya que resolverla sería una decisión editorial fuera del alcance de la traducción y quedó explícitamente marcada como "a criterio humano, no bloquea".
-->
