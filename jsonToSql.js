const fs = require("fs");

const dir = "./20230806";

const fileNames = fs.readdirSync(dir);

const transformBaseJsonInSql = jsonData => {
	return `INSERT INTO base ("ID EQP", "DATA HORA", "MILESEGUNDO", "FAIXA", "ID DE ENDEREÇO", "VELOCIDADE DA VIA", "VELOCIDADE AFERIDA", "CLASSIFICAÇÃO", "TAMANHO", "NUMERO DE SÉRIE", "LATITUDE", "LONGITUDE", "ENDEREÇO", "SENTIDO")
  VALUES (${parseFloat(jsonData["ID EQP"])}, '${jsonData["DATA HORA"]}', ${parseInt(
		jsonData["MILESEGUNDO"]
	)}, ${parseInt(jsonData["FAIXA"])}, ${parseInt(jsonData["ID DE ENDEREÇO"])}, ${parseFloat(
		jsonData["VELOCIDADE DA VIA"]
	)}, ${parseFloat(jsonData["VELOCIDADE AFERIDA"])}, '${jsonData["CLASSIFICAÇÃO"]}', ${parseFloat(
		jsonData["TAMANHO"]
	)}, ${parseInt(jsonData["NUMERO DE SÉRIE"])}, ${parseFloat(jsonData["LATITUDE"])}, ${parseFloat(
		jsonData["LONGITUDE"]
	)}, '${jsonData["ENDEREÇO"]}', '${jsonData["SENTIDO"]}');\n`;
};

const transformLeituraJsonInSql = jsonData => {
	return `INSERT INTO leituras (horario, faixa, velocidade_aferida, classificacao, tamanho, radar_id)
  VALUES ('${jsonData["DATA HORA"]}.${jsonData["MILESEGUNDO"]}', ${jsonData["FAIXA"]}, ${parseFloat(
		jsonData["VELOCIDADE AFERIDA"]
	)}, '${jsonData["CLASSIFICAÇÃO"]}', ${parseFloat(jsonData["TAMANHO"])}, ${jsonData["ID EQP"]});\n`;
};

const getRadarData = jsonData => ({
	id_eqp: jsonData["ID EQP"],
	velocidade_permitida: parseInt(jsonData["VELOCIDADE DA VIA"]),
	numero_serie: jsonData["NUMERO DE SÉRIE"],
	latitude: parseFloat(jsonData["LATITUDE"]),
	longitude: parseFloat(jsonData["LONGITUDE"]),
	endereco: jsonData["ENDEREÇO"],
	sentido: jsonData["SENTIDO"],
});

const transformRadarDataInSql = radarData => {
	const columns = Object.keys(radarData);

	return `INSERT INTO radares (${columns.join(", ")})
  VALUES (${radarData.id_eqp}, ${radarData.velocidade_permitida}, ${radarData.numero_serie}, ${radarData.latitude}, ${
		radarData.longitude
	}, '${radarData.endereco}', '${radarData.sentido}');\n`;
};

let insertsRadares = "";
const radaresMapped = [];

fileNames.forEach(fileName => {
	const originFileName = `${dir}/${fileName}`;
	const insertLeiturasPartSQL = `./migrations/3-insert_leituras/${fileName.replace(".json", ".sql")}`;
	const insertBasePartSQL = `./migrations/1-insert_base/${fileName.replace(".json", ".sql")}`;

	const leituras = require(originFileName);
	const base = require(originFileName);

	let insertsLeituras = "";
	let insertsBase = "";

	leituras.forEach(leitura => {
		const radarData = getRadarData(leitura);
		const { id_eqp } = radarData;

		if (!radaresMapped.includes(id_eqp)) {
			insertsRadares += transformRadarDataInSql(radarData);

			radaresMapped.push(id_eqp);
		}

		insertsLeituras += transformLeituraJsonInSql(leitura);
	});

	base.forEach(b => {
		insertsBase += transformBaseJsonInSql(b);
	});

	fs.writeFileSync(insertLeiturasPartSQL, insertsLeituras, { encoding: "utf-8" });
	fs.writeFileSync(insertBasePartSQL, insertsBase, { encoding: "utf-8" });
});

insertsRadares = insertsRadares.replace("Á", "á");

fs.writeFileSync("./migrations/2-insert_radares.sql", insertsRadares, { encoding: "utf-8" });
