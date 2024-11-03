//by zenx
//samp code https://discord.gg/gh3GStXzHf

#include <YSI_Coding\y_hooks>
#include <easyDialog>
#include <sscanf2>

#define MAX_EMP 35

enum Empresas {
    eNome[24],         
    eDono[24],          
    eSaldo,       
    Float:eEntradaX,      
    Float:eEntradaY,    
    Float:eEntradaZ,     
    eInterior,      
    eWorld        
};
new e_Empresa[MAX_EMP][Empresas];

hook OnGameModeInit() {
    if (Conexao) {
        Carregar_Empresas(); 
        printf("%d Empresas Foram Carregadas", Carregar_Empresas());
    }
    return 1;
}
hook OnGameModeExit() {
    SalvarEmps();
    printf("%d Empresas Foram Salvas", SalvarEmps());
    return 1;
}
stock CriarEmpresa(dono[24], nome[24], saldo, Float:posX, Float:posY, Float:posZ, interior, world) {
    mysql_format(Conexao, query, sizeof(query), 
        "INSERT INTO `empresas` (`Nome`, `Dono`, `Saldo`, `EntradaX`, `EntradaY`, `EntradaZ`, `Interior`, `World`) \
        VALUES ('%s', '%s', %d, %f, %f, %f, %d, %d)", 
        nome, dono, saldo, posX, posY, posZ, interior, world);
    mysql_query(Conexao, query); 
    return true;
}
stock Carregar_Empresas() {
    new rows;
    mysql_query(Conexao, "SELECT * FROM `empresas`");
    cache_get_row_count(rows);
    if (rows > 0) {
        for (new i = 0; i < rows && i < MAX_EMP; i++) {
            cache_get_value_name(i, "Nome", e_Empresa[i][eNome], 24);
            cache_get_value_name(i, "Dono", e_Empresa[i][eDono], 24);
            cache_get_value_int(i, "Saldo", e_Empresa[i][eSaldo]); 
            cache_get_value_float(i, "EntradaX", e_Empresa[i][eEntradaX]); 
            cache_get_value_float(i, "EntradaY", e_Empresa[i][eEntradaY]); 
            cache_get_value_float(i, "EntradaZ", e_Empresa[i][eEntradaZ]);
            cache_get_value_int(i, "Interior", e_Empresa[i][eInterior]); 
            cache_get_value_int(i, "World", e_Empresa[i][eWorld]);

            if (e_Empresa[i][eEntradaX] != 0.0) {
                CreateDynamic3DTextLabel(va_return("{ffffff}ID {00bfff}%d\n{ffffff}Empresa {00bfff}%s\n{ffffff}Dono: {00bfff}%s\n{ffffff}Saldo: {00bfff}R$%d", i, e_Empresa[i][eNome], e_Empresa[i][eDono], e_Empresa[i][eSaldo]), 0x00FF00FF, e_Empresa[i][eEntradaX], e_Empresa[i][eEntradaY], e_Empresa[i][eEntradaZ] + 0.5, 35.0);
                AddStaticPickup(19133, 23, e_Empresa[i][eEntradaX], e_Empresa[i][eEntradaY], e_Empresa[i][eEntradaZ]);             
            }
        }
    }
    return 1;
}
static stock SalvarEmps() {
    for (new idx = 0; idx < MAX_EMP; idx++) {
        mysql_format(Conexao, query, sizeof(query),
            "UPDATE empresas SET `Nome`='%s', `Dono`='%s', `Saldo`=%d, `EntradaX`=%f, `EntradaY`=%f, \
            `EntradaZ`=%f, `Interior`=%d, `World`=%d WHERE `ID`=%d",
            e_Empresa[idx][eNome],
            e_Empresa[idx][eDono],
            e_Empresa[idx][eSaldo],
            e_Empresa[idx][eEntradaX],
            e_Empresa[idx][eEntradaY],
            e_Empresa[idx][eEntradaZ],
            e_Empresa[idx][eInterior],
            e_Empresa[idx][eWorld], idx
        );
        mysql_query(Conexao, query); 
    }
    return 1;
}
CMD:criaremp(playerid, params[]) {
    new nome[24], playeremp, saldo;

    if (sscanf(params, "us[24]d", playeremp, nome, saldo)) return SendClientMessage(playerid, -1, "/criarempresa [id/nome do dono] [nome] [saldo inicial]");

    if (IsPlayerConnected(playeremp)) {
        if (playeremp != INVALID_PLAYER_ID) {

            new Float:posX, Float:posY, Float:posZ;
            GetPlayerPos(playerid, posX, posY, posZ);
            CriarEmpresa(PlayerName(playeremp), nome, saldo, posX, posY, posZ, 0, 0);

            CreateDynamic3DTextLabel(va_return("{ffffff}Empresa {00bfff}%s\n{ffffff}Dono: {00bfff}%s\n{ffffff}Saldo: {00bfff}R$%d", nome, PlayerName(playeremp), saldo), -1, posX, posY, posZ + 0.5, 35.0);
            AddStaticPickup(19133, 23, posX, posY, posZ, 0);
        }       
    }
    else {SendClientMessage(playerid, -1, "Jogador offline/id inválido");}
    return 1;
}
