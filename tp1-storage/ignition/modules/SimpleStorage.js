const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const SimpleStorageModule = buildModule("SimpleStorageModule", (m) => {
  const simpleStorage = m.contract("SimpleStorage");
  return { simpleStorage };
});

module.exports = SimpleStorageModule;
