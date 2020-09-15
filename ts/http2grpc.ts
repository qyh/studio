import { setInterval, setTimeout } from "timers";
const fetch = require('node-fetch');
import { URLSearchParams } from 'url';
import lodash from 'lodash';
import _ from 'lodash';
let token = "fASIa70Gnzn05CreWD6nhow08my2zia8"
let host = "http://ingress.gllkgame.com:50050"
let argv = process.argv
let env = argv[2] || "dev"
class Http {
    public async httpPost(host, body, header?:{}) {
        let content = null
        if (typeof(body) == 'string') {
            content = body
        } else if (typeof(body) == 'object') {
            for (let k in body) {
                let formData = new URLSearchParams();
                formData.append(k, body[k])
                content = formData 
            }
        }
        let headers = header || {}
        const r = await fetch(host, {
          method: 'POST',
          body: content,
          headers: headers,
        });
        let res = ""
        try{
            res = await r.json() 
        } catch(err) {
            res = err || r
        }
        return res
    }
}

class Request {
    private http: Http
    constructor() {
        this.http = new Http()
    }
    public async doRequest(env, service, path, data, metadata?) {
        let header = {
            'Content-Type':'application/json',
            'env': env,
            'authcode': token,
        }
        if (metadata) {
            for (let k in metadata) {
                header[k] = metadata[k]
            }
        }
        let body = {
        }
        for (let k in data) {
            body[k] = data[k]
        }
        let url = host + "/" + service + "/" + path
        console.log("url:", url)
        let rv = await this.http.httpPost(url, JSON.stringify(body), header)
        return rv
    }
    public regfuncs() {
        return {}
    } 
}

class Client {
    private param
    private request
    constructor(args) {
        this.param = args
        this.run = this.run.bind(this)
        this.req= this.req.bind(this)
        this.request = new Request()
    }
    public async run(req, data) {
        let res = await this.request.doRequest(this.param.env, req.service, req.path, data)
        return res
    }

    public async req(service, path, data, metadata?) {
        console.log("request:", service, path, data)
        let res = await this.request.doRequest(this.param.env, service, path, data, metadata)
        console.log("response:", res)
        return res
    }
}

function main() {
    let uid = 1792262 
    let gameId = 101
    let platformId = 999
    let reqs = new Array()
    setTimeout(async function(){
        ///////////////////////
        let http = new Http()
        let header = {
            'Content-Type':'application/json',
            'env': env,
            'authcode': token,
        }
        //通知connector重载接口权限配置
        http.httpPost("http://ingress.gllkgame.com:50050/connector/loadAuthorizations", "", header)
        ///////////////////////
        let client = new Client({
            env: env,
            uid: uid,
            gameId: gameId,
            platformId: platformId,
        })
        await client.req("mall", "reloadConfig", {
            configName: "all"
        }, {})
        let res = await client.req("mall", "getGoodsList", {
            guid : "5121-10001",
            gameId : 101,
            channelId: 999,
        }, {channelId: 999, platformId:10001}) 
        //console.log("goodsList:", res)
        for (let goods of res.goodsList) {
            console.log("goodsId:", goods.mallId, goods.region)
        }

        res = await client.req("mall", "getRegionInfo", {
        }, {channelId:101, platformId:10000})
        console.log("getRegionInfo:", res)

        res = await client.req("mall", "unifiedOrder", {
            userInfo: {guid: "5121-10001", nickName: "robot121"},
            kind: 101,
            mallId: 26,
            appId: "wxebee255d2d4891ff",
            payItemId: 108,
            num : 1,
            channelId: 999
        })
        console.log("res", res)
        
    }, 1)
}

main()

