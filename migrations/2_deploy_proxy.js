const Token = artifacts.require('Token')
const Proxy = artifacts.require('Proxy')
const TokenUpdated = artifacts.require('TokenUpdated')

module.exports = async function(deployer, network, accounts){
    const token = await Token.new(); 
    const proxy = await Proxy.new(token.address); 

    // sending through Proxy
    var proxyDog = await Token.at(proxy.address); 

    await proxyDog.setNumberOfToken(10); 

    var nrOfToken = await proxyDog.getNumberOfToken(); 
    console.log(nrOfToken.toNumber()); 

    const tokenUpdated = await TokenUpdated.new(); 

    proxy.upgrade(tokenUpdated.address); 
    
    proxyDog = await TokenUpdated.at(proxy.address) 
    proxyDog.initialize(accounts[0]); 

    nrOfToken = await proxyDog.getNumberOfToken(); 
    console.log("After update: " + nrOfToken.toNumber());

    await proxyDog.setNumberOfToken(30); 

}