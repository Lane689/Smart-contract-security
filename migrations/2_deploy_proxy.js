const Dogs = artifacts.require('Dogs')
const Proxy = artifacts.require('Proxy')
const DogsUpdated = artifacts.require('DogsUpdated')

module.exports = async function(deployer, network, accounts){
    const dogs = await Dogs.new(); // new() takes source file and deploy so we get deployed instance of this contract
    const proxy = await Proxy.new(dogs.address); // jer Proxy ima contructor koji ocekuje adresu


    // sending through Proxy
    var proxyDog = await Dogs.at(proxy.address); // we fooling truffle to believe that Proxy contract is really the Dog contract
    // .at() - create intance of Dog contract but do that from already exsitging deployed contract
    // we pointing to a Proxy contract with proxy.address but we are telling truffle that this is the Dog contract

    // setting nummber of dogs through the proxy
    await proxyDog.setNumberOfDogs(10); 

    var nrOfDogs = await proxyDog.getNumberOfDogs(); 
    console.log(nrOfDogs.toNumber()); 

    // ovo ce izbaciti 0 i to i zelimo, ne zelimo da data bude storeana u functionl (dog) contractu, vec u proxy and  
    // we can access it going the proxy
    // nrOfDogs = await dogs.getNumberOfDogs(); 
    // console.log(nrOfDogs.toNumber()); 

    const dogsUpdated = await DogsUpdated.new(); 

    // Switching that the proxy is using this contract instead of Dogs
    // Koristimo proxy jer truffle sad vjeruje da je proxyDog actual Dog contract
    proxy.upgrade(dogsUpdated.address); // currentAddress becomes _newAddress (from Proxy contract)
    
    proxyDog = await DogsUpdated.at(proxy.address) // because we add functionality (function initialize), again fooling truffle, it now thinks that
                                                    //proxyDog has all functions, including initialize() 
    proxyDog.initialize(accounts[0]); // take our current address, account from where we are going to use for all deployments, our own address 

    nrOfDogs = await proxyDog.getNumberOfDogs(); // this will now use the new updated contract
    console.log("After update: " + nrOfDogs.toNumber());

    // setting nummber of dogs through the proxy with new functional contract
    await proxyDog.setNumberOfDogs(30); 

}