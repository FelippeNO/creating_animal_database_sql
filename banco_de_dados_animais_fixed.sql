SCRIPT SQL – BANCO DE ANIMAIS VERTEBRADOS



--CREATING DATABASE

-- Database: bancoanimais

-- DROP DATABASE IF EXISTS teste;

CREATE DATABASE bancoanimais
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- CREATING TABLES

-- Table: public.Alimentacao

-- DROP TABLE IF EXISTS public."Alimentacao";

CREATE TABLE IF NOT EXISTS public."Alimentacao"
(
    id_alimentacao integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    tipo_alimentacao text COLLATE pg_catalog."default" NOT NULL,
    descricao_alimentacao text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Alimentacao_pkey" PRIMARY KEY (id_alimentacao),
    CONSTRAINT "Alimentacao_ukey" UNIQUE (tipo_alimentacao)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Alimentacao"
    OWNER to postgres;

-- Table: public.Bioma

-- DROP TABLE IF EXISTS public."Bioma";

CREATE TABLE IF NOT EXISTS public."Bioma"
(
    id_bioma integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome_bioma text COLLATE pg_catalog."default" NOT NULL,
    vegetacao text COLLATE pg_catalog."default" NOT NULL,
    localizacoes text COLLATE pg_catalog."default" NOT NULL,
    temperatura_media integer NOT NULL,
    umidade integer NOT NULL,
    CONSTRAINT "Bioma_pkey" PRIMARY KEY (id_bioma),
    CONSTRAINT "Bioma_ukey" UNIQUE (nome_bioma)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Bioma"
    OWNER to postgres;

-- Table: public.GrauExtincao

-- DROP TABLE IF EXISTS public."GrauExtincao";

CREATE TABLE IF NOT EXISTS public."GrauExtincao"
(
    id_grau_ext integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome_grau_ext text COLLATE pg_catalog."default" NOT NULL,
    sigla_grau_ext text COLLATE pg_catalog."default" NOT NULL,
    cores text COLLATE pg_catalog."default" NOT NULL,
    reduc_populacao integer NOT NULL,
    CONSTRAINT "GrauExtincao_pkey" PRIMARY KEY (id_grau_ext),
    CONSTRAINT "GrauExtincao_ukey" UNIQUE (nome_grau_ext, sigla_grau_ext)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."GrauExtincao"
    OWNER to postgres;

-- Table: public.Respiracao

-- DROP TABLE IF EXISTS public."Respiracao";

CREATE TABLE IF NOT EXISTS public."Respiracao"
(
    id_respiracao integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    tipo_respiracao text COLLATE pg_catalog."default" NOT NULL,
    descricao_respiracao text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Respiracao_pkey" PRIMARY KEY (id_respiracao),
    CONSTRAINT "Respiracao_ukey" UNIQUE (tipo_respiracao)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Respiracao"
    OWNER to postgres;

-- Table: public.Classe

-- DROP TABLE IF EXISTS public."Classe";

CREATE TABLE IF NOT EXISTS public."Classe"
(
    id_classe integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome_classe text COLLATE pg_catalog."default" NOT NULL,
    descricao_classe text COLLATE pg_catalog."default" NOT NULL,
    respiracao_id_respiracao integer NOT NULL,
    CONSTRAINT "Classe_pkey" PRIMARY KEY (id_classe),
    CONSTRAINT "Classe_ukey" UNIQUE (nome_classe),
    CONSTRAINT "Respiracao_fkey" FOREIGN KEY (respiracao_id_respiracao)
        REFERENCES public."Respiracao" (id_respiracao) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Classe"
    OWNER to postgres;

-- Table: public.Animal

-- DROP TABLE IF EXISTS public."Animal";

CREATE TABLE IF NOT EXISTS public."Animal"
(
    id_animal integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    nome_cientifico text COLLATE pg_catalog."default" NOT NULL,
    nome_popular text COLLATE pg_catalog."default" NOT NULL,
    expectativa_vida integer NOT NULL,
    alimentacao_id_alimentacao integer NOT NULL,
    grau_ext_id_grau_ext integer NOT NULL,
    bioma_id_bioma integer NOT NULL,
    classe_id_classe integer NOT NULL,
    CONSTRAINT "Animal_pkey" PRIMARY KEY (id_animal),
    CONSTRAINT "Animal_ukey" UNIQUE (nome_cientifico),
    CONSTRAINT "Animal_Alimentacao_fkey" FOREIGN KEY (alimentacao_id_alimentacao)
        REFERENCES public."Alimentacao" (id_alimentacao) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Animal_Bioma_fkey" FOREIGN KEY (bioma_id_bioma)
        REFERENCES public."Bioma" (id_bioma) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Animal_Classe_fkey" FOREIGN KEY (classe_id_classe)
        REFERENCES public."Classe" (id_classe) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Animal_GrauExtincao_fkey" FOREIGN KEY (grau_ext_id_grau_ext)
        REFERENCES public."GrauExtincao" (id_grau_ext) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Animal"
    OWNER to postgres;


--INSERTS

INSERT INTO public."Respiracao" (
tipo_respiracao, descricao_respiracao) VALUES (
'Pulmonar'::text, 'A respiração pulmonar é um processo em que ocorre a entrada de ar em nossos pulmões e sua posterior eliminação. A entrada do ar é importante, pois garante que oxigênio seja levado até o sangue para, então, ser distribuído às células.'::text)
 returning id_respiracao;

INSERT INTO public."Respiracao" (
tipo_respiracao, descricao_respiracao) VALUES (
'Cutânea'::text, 'A respiração cutânea ou tegumentar é definida como o processo em que os animais realizam trocas gasosas diretamente entre sua superfície corporal e o ambiente.'::text)
 returning id_respiracao;

INSERT INTO public."Respiracao" (
tipo_respiracao, descricao_respiracao) VALUES (
'Branquial'::text, 'A respiração branquial ocorre por meio de brânquias, que são estruturas ricamente vascularizadas. É nas brânquias que o oxigênio presente na água passa para o interior do corpo e que o dióxido de carbono que está no corpo do animal passa para a água.'::text)
 returning id_respiracao;

INSERT INTO public."GrauExtincao" (
nome_grau_ext, sigla_grau_ext, cores, reduc_populacao) VALUES (
'Quase Ameaçado'::text, 'NT'::text, 'Fundo Verde, Letra Verde'::text, '40'::integer)
 returning id_grau_ext;

INSERT INTO public."GrauExtincao" (
nome_grau_ext, sigla_grau_ext, cores, reduc_populacao) VALUES (
'Pouco preocupante'::text, 'LC'::text, 'Fundo Verde, Letra Branca'::text, '20'::integer)
 returning id_grau_ext;

INSERT INTO public."GrauExtincao" (
nome_grau_ext, sigla_grau_ext, cores, reduc_populacao) VALUES (
'Em Perigo'::text, 'EN'::text, 'Fundo Laranja, Letra Laranja'::text, '60'::integer)
 returning id_grau_ext;

INSERT INTO public."GrauExtincao" (
nome_grau_ext, sigla_grau_ext, cores, reduc_populacao) VALUES (
'Vulnerável'::text, 'VU'::text, 'Fundo Amarelo, Letra Amarela'::text, '50'::integer)
 returning id_grau_ext;

INSERT INTO public."Bioma" (
nome_bioma, localizacoes, temperatura_media, umidade, vegetacao) VALUES (
'Cerrado'::text, 'Brasil Central'::text, '22'::integer, '70'::integer, 'A vegetação que compõe o Cerrado é formada por árvores com troncos tortuosos, arbustos e gramíneas.'::text)
 returning id_bioma;

INSERT INTO public."Bioma" (
nome_bioma, localizacoes, temperatura_media, umidade, vegetacao) VALUES (
'Savana'::text, 'América do Sul, África, Oceania e Ásia'::text, '20'::integer, '44'::integer, 'As savanas apresentam tanto formações arbustivas quanto formações arbóreas. As árvores da savana apresentam raízes profundas, folhas grossas e troncos retorcidos. Essas características permitem que essa vegetação seja resistente ao período de estiagem típico do clima em que está localizada.'::text)
 returning id_bioma;

INSERT INTO public."Bioma" (
nome_bioma, localizacoes, temperatura_media, umidade, vegetacao) VALUES (
'Floresta Mediterrânea'::text, 'Sul da Europa, Oriente Médio, Norte da África e América do Sul.'::text, '18'::integer, '80'::integer, 'A maior parte das espécies da vegetação mediterrânea é exclusiva dessa formação vegetal. É constituída por espécies adaptadas a longos períodos de estiagem, como os maquis e garrigues, além de árvores de pequeno porte, como as oliveiras.'::text)
 returning id_bioma;

INSERT INTO public."Bioma" (
nome_bioma, localizacoes, temperatura_media, umidade, vegetacao) VALUES (
'Marinho'::text, 'Mares e Oceanos.'::text, '6'::integer, '100'::integer, 'A flora do ambiente marinho é caracterizado principalmente por algas.'::text)
 returning id_bioma;

INSERT INTO public."Bioma" (
nome_bioma, localizacoes, temperatura_media, umidade, vegetacao) VALUES (
'Foresta Tropical'::text, 'Áreas equatoriais.'::text, '29'::integer, '82'::integer, 'A cobertura vegetal é densa com muitas árvores de grande porte. É comum encontrar lianas e plantas epífitas.'::text)
 returning id_bioma;

INSERT INTO public."Bioma" (
nome_bioma, localizacoes, temperatura_media, umidade, vegetacao) VALUES (
'Floresta Temperada'::text, 'Regiões entre os polos e trópicos da Terra de clima temperado.'::text, '5'::integer, '60'::integer, 'A vegetação dessas florestas varia desde enormes árvores até pequenos arbustos: carvalhos, pinheiros, cedros, faias, sobreiros, sequóias, etc. '::text)
 returning id_bioma;

INSERT INTO public."Alimentacao" (
tipo_alimentacao, descricao_alimentacao) VALUES (
'Carnívoro Terciário'::text, 'Os animais carnívoros são aqueles que se alimentam predominantemente da carne de outros animais. Consumidores terciários: se a fonte de alimento for outro animal carnívoro.'::text)
 returning id_alimentacao;

INSERT INTO public."Alimentacao" (
tipo_alimentacao, descricao_alimentacao) VALUES (
'Onívoro'::text, 'Os onívoros ou onívoros são os animais com capacidade para metabolização de diferentes classes alimentícias, com uma dieta alimentar menos restrita que a dos carnívoros ou herbívoros.'::text)
 returning id_alimentacao;

INSERT INTO public."Alimentacao" (
tipo_alimentacao, descricao_alimentacao) VALUES (
'Carnívoro Secundário'::text, 'Os animais carnívoros são aqueles que se alimentam predominantemente da carne de outros animais.Consumidores secundários: se a fonte de alimentação for os animais herbívoros.'::text)
 returning id_alimentacao;

INSERT INTO public."Alimentacao" (
tipo_alimentacao, descricao_alimentacao) VALUES (
'Herbívoro'::text, 'São aqueles animais que se alimentam de plantas e/ou algas.'::text)
 returning id_alimentacao;

INSERT INTO public."Classe" (
nome_classe, descricao_classe, respiracao_id_respiracao) VALUES (
'Mamífero'::text, 'Apresentam pelos em todo corpo. No caso dessa classe, a fêmea que alimenta os filhotes com o leite de suas mamas. Os seres humanos se encaixam nessa categoria. Também respiram pelo pulmão e conseguem regular a temperatura dos seus corpos.'::text, '1'::integer)
 returning id_classe;

INSERT INTO public."Classe" (
nome_classe, descricao_classe, respiracao_id_respiracao) VALUES (
'Ave'::text, 'Aves são uma classe de seres vivos vertebrados endotérmicos caracterizada pela presença de penas, um bico sem dentes, oviparidade de casca rígida, elevado metabolismo, um coração com quatro câmaras e um esqueleto pneumático resistente e leve. '::text, '1'::integer)
 returning id_classe;

INSERT INTO public."Classe" (
nome_classe, descricao_classe, respiracao_id_respiracao) VALUES (
'Réptil'::text, 'Os répteis constituem uma classe de animais vertebrados tetrápodes e ectotérmicos, ou seja, não possuem temperatura corporal constante. São todos amniotas, característica que lhes permitiu ficarem independentes da água para reprodução, ao contrário dos anfíbios.'::text, '1'::integer)
 returning id_classe;

INSERT INTO public."Classe" (
nome_classe, descricao_classe, respiracao_id_respiracao) VALUES (
'Peixe'::text, 'Nesse grupo de animais, temos representantes com corpo tipicamente fusiforme; respiração, geralmente, do tipo branquial; presença de nadadeiras; e ectotermia.'::text, '3'::integer)
 returning id_classe;

INSERT INTO public."Classe" (
nome_classe, descricao_classe, respiracao_id_respiracao) VALUES (
'Anfíbio'::text, 'Anfíbios são animais vertebrados que vivem entre o meio aquático e o ambiente terrestre. Eles mantêm uma forte vinculação com a água e dela não se afastam, pois precisam manter a pele úmida. A fecundação desses animais geralmente é externa e ocorre na água.'::text, '2'::integer)
 returning id_classe;

INSERT INTO public."Animal" (
nome_cientifico, nome_popular, expectativa_vida, alimentacao_id_alimentacao, grau_ext_id_grau_ext, bioma_id_bioma, classe_id_classe) VALUES (
'Speothos venaticus'::text, 'Cachorro-vinagre'::text, '10'::integer, '1'::integer, '1'::integer, '1'::integer, '1'::integer)
 returning id_animal;

INSERT INTO public."Animal" (
nome_cientifico, nome_popular, expectativa_vida, alimentacao_id_alimentacao, grau_ext_id_grau_ext, bioma_id_bioma, classe_id_classe) VALUES (
'Struthio camelus'::text, 'Avestruz'::text, '50'::integer, '2'::integer, '2'::integer, '2'::integer, '2'::integer)
 returning id_animal;

INSERT INTO public."Animal" (
nome_cientifico, nome_popular, expectativa_vida, alimentacao_id_alimentacao, grau_ext_id_grau_ext, bioma_id_bioma, classe_id_classe) VALUES (
'Varanus komodensis'::text, 'Dragão de Komodo'::text, '40'::integer, '3'::integer, '3'::integer, '3'::integer, '3'::integer)
 returning id_animal;

INSERT INTO public."Animal" (
nome_cientifico, nome_popular, expectativa_vida, alimentacao_id_alimentacao, grau_ext_id_grau_ext, bioma_id_bioma, classe_id_classe) VALUES (
'Physeter macrocephalus'::text, 'Baleia Cachalote'::text, '70'::integer, '3'::integer, '4'::integer, '4'::integer, '1'::integer)
 returning id_animal;

INSERT INTO public."Animal" (
nome_cientifico, nome_popular, expectativa_vida, alimentacao_id_alimentacao, grau_ext_id_grau_ext, bioma_id_bioma, classe_id_classe) VALUES (
'Haplobatrachus tigerinus'::text, 'Sapo-boi Indiano'::text, '10'::integer, '3'::integer, '2'::integer, '5'::integer, '5'::integer)
 returning id_animal;

INSERT INTO public."Animal" (
nome_cientifico, nome_popular, expectativa_vida, alimentacao_id_alimentacao, grau_ext_id_grau_ext, bioma_id_bioma, classe_id_classe) VALUES (
'Ornithorhyncus anatinus'::text, 'Ornitorrinco'::text, '17'::integer, '3'::integer, '2'::integer, '6'::integer, '1'::integer)
 returning id_animal;

--SELECTS

SELECT * FROM "Animal";

SELECT * FROM "Alimentacao";

SELECT * FROM "Respiracao";

SELECT * FROM "Classe";

SELECT * FROM "Bioma";

SELECT * FROM "GrauExtincao";

select animal.id_animal, animal.nome_popular, classe.nome_classe, classe.descricao_classe, grauext.nome_grau_ext from public."Animal" as animal
full join public."Classe" as classe on animal.classe_id_classe = classe.id_classe
full join public."GrauExtincao" as grauext on animal.grau_ext_id_grau_ext = grauext.id_grau_ext

SELECT Animal.id_animal, Animal.nome_popular, Bioma.nome_bioma, MAX(Bioma.temperatura_media) from "Animal" as Animal
full join "Bioma" as bioma on Animal.Bioma_id_bioma = Bioma.id_bioma group by bioma.nome_bioma, Animal.id_animal;

SELECT "Classe".nome_classe, count("Animal".*) 
FROM "Classe" inner Join "Animal" on "Animal".classe_id_classe = "Classe".id_classe 
GROUP by "Classe".nome_classe ;

SELECT MAX(temperatura_media) FROM "Bioma"; 

SELECT COUNT(id_animal) FROM  "Animal" WHERE expectativa_vida > 10;

SELECT nome_grau_ext, sigla_grau_ext FROM "GrauExtincao" WHERE reduc_populacao > (SELECT AVG(reduc_populacao) FROM "GrauExtincao");

--ALTERS

ALTER TABLE Classe
ALTER COLUMN descricao_classe SET NOT NULL;

--DROP COLUMN

ALTER TABLE Bioma DROP COLUMN vegetacao;
