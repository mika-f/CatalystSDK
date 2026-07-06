import { CatalystReactions } from "./reactions.js";
import { EgeriaUser } from "./users.js";

export interface CatalystCreateFleetMediaPlacement {
  posX: number;
  posY: number;
  scale?: number;
  rotation?: number;
}

export interface CatalystCreateFleetMedia {
  url: string;
  alt?: string;
  width: number;
  height: number;
  bytes: number;
  placement: CatalystCreateFleetMediaPlacement;
}

export interface CatalystCreateFleetText {
  body: string;
  backgroundColor?: string;
  textStyle?: "default" | "bold" | "serif" | "handwriting";
  textAlignment?: "left" | "center" | "right";
  color?: string;
  posX: number;
  posY: number;
  scale?: number;
  rotation?: number;
}

export interface CatalystCreateFleetSticker {
  posX: number;
  posY: number;
  scale?: number;
  rotation?: number;
  emoji: string;
}

export interface CatalystCreateFleetRequest {
  backgroundColor?: string;
  texts?: CatalystCreateFleetText[];
  media: CatalystCreateFleetMedia;
  stickers?: CatalystCreateFleetSticker[];
}

export interface CatalystFleetText {
  id: string;
  body: string;
  textStyle: string;
  textAlignment: string;
  color: string;
  backgroundColor?: string;
  posX: number;
  posY: number;
  scale: number;
  rotation: number;
}

export interface CatalystFleetSticker {
  id: string;
  emoji: string;
  posX: number;
  posY: number;
  scale: number;
  rotation: number;
}

export interface CatalystFleetMedia {
  url: string;
  alt: string;
  width: number | null;
  height: number | null;
  placement?: {
    posX: number;
    posY: number;
    scale: number;
    rotation: number;
  };
}

export interface CatalystFleet extends CatalystReactions {
  id: string;
  backgroundColor: string;
  renderedImageUrl: string | null;
  user: EgeriaUser;
  texts: CatalystFleetText[];
  media: CatalystFleetMedia | null;
  stickers: CatalystFleetSticker[];
  viewCount: number;
  createdAt: string;
  expiresAt: string;
}

export interface CatalystFleetViewer {
  user: EgeriaUser;
  viewedAt: string;
}

export interface CatalystFleetRing {
  user: EgeriaUser;
  hasUnread: boolean;
  fleetCount: number;
}
