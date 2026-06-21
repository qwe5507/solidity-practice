// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// OpenZeppelin의 검증된 표준 컨트랙트들을 가져옵니다.
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title MyNFT
/// @notice 소유자만 발행(mint)할 수 있는 간단한 ERC-721 NFT 컨트랙트
contract MyNFT is ERC721, ERC721URIStorage, Ownable {
    // 다음에 발행될 토큰의 ID. 0부터 시작해 1씩 증가합니다.
    uint256 private _nextTokenId;

    // 배포할 때 NFT 컬렉션 이름과 심볼, 그리고 소유자 주소를 정합니다.
    // 예: name="My NFT Collection", symbol="MNFT"
    constructor(address initialOwner)
        ERC721("My NFT Collection", "MNFT")
        Ownable(initialOwner)
    {}

    /// @notice 새 NFT를 발행해 `to` 주소에게 보냅니다. (소유자만 호출 가능)
    /// @param to NFT를 받을 주소
    /// @param uri 이 NFT의 메타데이터 JSON 위치 (예: ipfs://... 또는 https://...)
    /// @return tokenId 새로 발행된 토큰의 ID
    function safeMint(address to, string memory uri)
        public
        onlyOwner
        returns (uint256)
    {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        return tokenId;
    }

    /// @notice 지금까지 발행된 NFT의 총 개수를 반환합니다.
    function totalMinted() public view returns (uint256) {
        return _nextTokenId;
    }

    // ----- 아래는 다중 상속 시 Solidity가 요구하는 함수 재정의(override)입니다 -----

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
