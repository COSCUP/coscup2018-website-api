#!/usr/bin/env node

let lang = process.argv[2]

const fs = require('fs')
const path = require('path')
const _root = path.resolve(__dirname, '..')

function pick(object, keys) {
	if(!object || !keys) return {}
	return Object.keys(object).filter(k => keys.includes(k)).reduce((obj, k) => { return { ...obj, [k]: object[k] } }, {})
}

let json = fs.readFileSync(path.join(_root, 'dist', lang, 'programs.json'))
let { talks, tracks, speakers, communities } = JSON.parse(json)

let programsDir = path.join(_root, 'dist', lang, 'programs')
if(!fs.existsSync(programsDir)) fs.mkdirSync(programsDir)

Object.keys(talks).forEach(k => {
	let talk = talks[k]
	fs.writeFileSync(`${programsDir}/${k}.json`, JSON.stringify({
		talks: { [k]: talk },
		tracks: { [talk.track]: tracks[talk.track] },
		speakers: pick(speakers, talk.speakers),
		communities: pick(communities, talk.communities),
	}))
})
