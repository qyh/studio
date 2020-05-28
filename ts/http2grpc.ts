import { setInterval, setTimeout } from "timers";
const fetch = require('node-fetch');
import { URLSearchParams } from 'url';
//import lodash from 'lodash';
//import _ from 'lodash';
let token = "fASIa70Gnzn05CreWD6nhow08my2zia8"
let host = "http://ingress.gllkgame.com:50050"


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
    public async doRequest(env, service, path, data) {
        let header = {
            'Content-Type':'application/json',
            'env': env,
            'authcode': token,
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
        this.request = new Request()
    }
    public async run(req, data) {
        let res = await this.request.doRequest(this.param.env, req.service, req.path, data)
        return res
    }
}

function main() {
    let env = "dev"
    let uid = 1792262 
    let gameId = 101
    let platformId = 999
    //商城统一下单
    let unifiedOrder = {
        service: "mall",
        path: "unifiedOrder",
        data: {
            userInfo : {
                uid : 1792262,
                nickName : "qyh",
            },
            mallId: 19,
            payItemId: 108,
            num: 2,
        }
    }
    //getGoodsList
    let getGoodsList = {
        service: "mall",
        path: "getGoodsList",
        data: {
            uid: 1792262,
            gameId: 101,
            platformId: 999,
        }
    }
    // im.test
    let im_test = {
        service: "im",
        path: "test",
        data: {
            test:"hello"
        }
    }
    let reqs = new Array()
    reqs.push(im_test)
    reqs.push(getGoodsList)
    //reqs.push(unifiedOrder)
    setTimeout(async function(){
        let client = new Client({
            env: env,
            uid: uid,
            gameId: gameId,
            platformId: platformId,
        })
        console.log("env:", env)
        for (let i in reqs) {
            let req = reqs[i]
            console.log(`request ${i}: `, req)
            let rv = await client.run(req, req.data)
            console.log(`response ${i}: `, rv)
        }
    }, 1)
}

main()

